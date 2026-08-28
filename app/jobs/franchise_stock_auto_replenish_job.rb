# When a booking is assigned to a franchise for delivery but the franchise
# doesn't hold enough of an item in FranchiseInventory yet (see
# Admin::BookingsController#franchise_stock_shortfall), rather than block
# the assignment we auto-create a FranchiseStockRequest for exactly the
# shortfall and immediately auto-approve it as `actor` — the same effect as
# an admin filling out and approving a wholesale request by hand from
# Franchise::StockRequestsController / Admin::FranchiseStockRequestsController,
# just skipped straight to approved — then finish the delivery assignment.
# Pulled into a job (like StockTransferBulkActionJob) because the wholesale
# booking + stock transfer can be slow enough to hit a request timeout, and
# progress is written to the cache under `token` so the admin UI can poll it
# and show a progress bar while this runs.
class FranchiseStockAutoReplenishJob < ApplicationJob
  queue_as :default

  CACHE_EXPIRY = 30.minutes

  def perform(booking_id, franchise_id, actor_id, transition_data, token)
    actor = User.find(actor_id)
    booking = Booking.find(booking_id)
    franchise = Franchise.find(franchise_id)
    transition_data = transition_data.deep_symbolize_keys

    write_progress(token, step: "Checking #{franchise.name}'s stock", percent: 10, done: false)

    shortfall_items = shortfall_items_for(booking, franchise)

    if shortfall_items.any?
      write_progress(token, step: "Requesting stock from HQ on #{franchise.name}'s behalf", percent: 30, done: false)

      stock_request = FranchiseStockRequest.create!(
        franchise: franchise,
        notes: "Auto-generated to cover a shortfall found while assigning Booking ##{booking.booking_number} to #{franchise.name} for delivery",
        items_attributes: shortfall_items.map { |si| { product_id: si[:product_id], quantity: si[:quantity] } }
      )

      write_progress(token, step: "Approving stock request ##{stock_request.id}", percent: 55, done: false)

      unless stock_request.approve!(actor)
        write_progress(token, done: true, success: false,
          error: "Couldn't auto-approve the replenishment request: #{stock_request.errors.full_messages.to_sentence}")
        return
      end
    end

    write_progress(token, step: "Assigning booking to #{franchise.name}", percent: 80, done: false)

    FranchiseDeliveryAssignmentService.new(
      booking: booking, franchise: franchise, actor: actor, transition_data: transition_data
    ).call!

    write_progress(token, done: true, success: true, percent: 100,
      message: "#{franchise.name} assigned and booking updated successfully.")
  rescue => e
    Rails.logger.error "FranchiseStockAutoReplenishJob failed for booking ##{booking_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    write_progress(token, done: true, success: false, error: e.message)
  end

  private

  def shortfall_items_for(booking, franchise)
    booking.booking_items.includes(:product).filter_map do |item|
      next if item.product_id.blank? || item.quantity.to_f <= 0

      available = FranchiseInventory.balance_for(franchise, item.product).to_f
      shortfall = item.quantity.to_f - available
      next if shortfall <= 0

      { product_id: item.product_id, quantity: shortfall }
    end
  end

  def write_progress(token, **data)
    Rails.cache.write("franchise_stock_replenish_progress:#{token}", data, expires_in: CACHE_EXPIRY)
  end
end
