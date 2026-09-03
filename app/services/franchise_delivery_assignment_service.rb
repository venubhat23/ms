# Finishes handing a booking over to a franchise for delivery: transfers the
# booking's items out of central stock and into the franchise's own
# FranchiseInventory ledger, then applies the 'out_for_delivery' stage
# transition — all in one transaction. Pulled out of
# Admin::BookingsController#update_stage so the same stock-transfer logic
# can also run from FranchiseStockAutoReplenishJob (after it auto-approves a
# FranchiseStockRequest to cover a shortfall) without duplicating it.
class FranchiseDeliveryAssignmentService
  def initialize(booking:, franchise:, actor:, transition_data:)
    @booking = booking
    @franchise = franchise
    @actor = actor
    @transition_data = transition_data.symbolize_keys
  end

  def call!
    ActiveRecord::Base.transaction do
      restore_central_stock! unless SystemSetting.stock_allocation_at_delivery_enabled?
      consume_franchise_stock!
      @booking.update_column(:stock_allocated_at, Time.current) if SystemSetting.stock_allocation_at_delivery_enabled? && @booking.stock_allocated_at.nil?
      apply_transition!
    end
  end

  private

  # Deducts each of @booking's items from the franchise's own inventory
  # ledger. Shortfalls are allowed to push the balance negative rather than
  # blocking the assignment (allow_negative: true) — the negative figure is
  # the stock the franchise now owes HQ, cleared next time they're restocked.
  def consume_franchise_stock!
    @booking.booking_items.each do |item|
      next if item.product_id.blank? || item.quantity.to_f <= 0

      FranchiseInventory.consume_stock!(
        @franchise, item.product, item.quantity,
        reference_type: 'franchise_delivery_assignment',
        reference_id: @booking.id,
        notes: "Delivery assignment for Booking ##{@booking.booking_number}",
        allow_negative: true
      )
    end
  end

  # Central stock for every booking_item was already deducted at booking
  # creation time (see BookingItem#reduce_product_stock), long before it
  # ever reaches this stage. Once a franchise takes over delivery and
  # fulfils it from their own on-shelf FranchiseInventory (see
  # consume_franchise_stock!), the central warehouse is no longer shipping
  # this order — so its stock claim on central inventory is released back.
  def restore_central_stock!
    @booking.booking_items.includes(:product).each do |item|
      product = item.product
      next if product.blank? || item.quantity.to_f <= 0

      sale_items = SaleItem.where(booking: @booking, product: product)

      if sale_items.exists?
        sale_items.find_each do |sale_item|
          batch = sale_item.stock_batch
          next unless batch

          stock_before = batch.quantity_remaining
          batch.quantity_remaining += sale_item.quantity
          batch.status = 'active' if batch.exhausted? && batch.quantity_remaining > 0
          batch.save!

          StockMovement.create!(
            product: product,
            reference_type: 'franchise_delivery_assignment',
            reference_id: @booking.id,
            movement_type: 'added',
            quantity: sale_item.quantity,
            stock_before: stock_before,
            stock_after: batch.quantity_remaining,
            notes: "Stock returned to central inventory — Booking ##{@booking.booking_number} handed to #{@franchise.name} for delivery"
          )

          sale_item.destroy
        end
      else
        restore_scope = @booking.store_id.present? \
          ? product.stock_batches.where(store_id: @booking.store_id).order(:batch_date, :created_at) \
          : product.stock_batches.order(:batch_date, :created_at)

        current_stock = restore_scope.sum(:quantity_remaining)
        quantity_to_restore = item.quantity.to_f

        restore_scope.reverse_each do |batch|
          break if quantity_to_restore <= 0

          if batch.status == 'exhausted' || batch.status == 'active'
            batch.quantity_remaining += quantity_to_restore
            batch.status = 'active'
            batch.save!
            quantity_to_restore = 0
            break
          end
        end

        StockMovement.create!(
          product: product,
          reference_type: 'franchise_delivery_assignment',
          reference_id: @booking.id,
          movement_type: 'added',
          quantity: item.quantity.to_f,
          stock_before: current_stock,
          stock_after: current_stock + item.quantity.to_f,
          notes: "Stock returned to central inventory — Booking ##{@booking.booking_number} handed to #{@franchise.name} for delivery"
        )
      end

      product.update_column(:stock, product.total_batch_stock)
    end
  end

  # Only ever invoked for the 'out_for_delivery' + delivery_mode: 'franchise'
  # transition (the only path that ever reaches this service — see
  # Admin::BookingsController#build_stage_transition_data), so unlike the
  # controller's generic update_booking_with_stage_transition this only
  # needs to handle that one case plus the shared stage_history/notes
  # bookkeeping every transition gets.
  def apply_transition!
    @booking.status = 'out_for_delivery'
    @booking.delivery_mode = 'franchise'
    @booking.delivery_franchise_id = @transition_data[:delivery_franchise_id].presence || @franchise.id

    history = begin
      @booking.stage_history.present? ? JSON.parse(@booking.stage_history) : []
    rescue JSON::ParserError
      []
    end
    history << @transition_data.stringify_keys
    @booking.stage_history = history.to_json
    @booking.stage_updated_at = Time.current
    @booking.stage_updated_by = @actor.id

    if @transition_data[:notes].present?
      @booking.transition_notes = [@booking.transition_notes, @transition_data[:notes]].compact.join("\n---\n")
    end

    @booking.save!
  end
end
