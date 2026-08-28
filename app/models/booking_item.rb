class BookingItem < ApplicationRecord
  belongs_to :booking, counter_cache: true
  belongs_to :product
  belongs_to :product_variant, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # Guarded like the lead.rb uniqueness fix: this fires an extra SUM query
  # against stock_batches, so only run it when quantity/product actually
  # changed (including on create) instead of on every save.
  validate :check_stock_availability, if: -> { will_save_change_to_quantity? || will_save_change_to_product_id? }

  before_save :calculate_total
  after_create :reduce_product_stock
  after_update :handle_quantity_change, if: :saved_change_to_quantity?
  after_destroy :restore_product_stock

  def calculate_total
    self.total = quantity * price
  end

  private

  def check_stock_availability
    return unless quantity.present? && product.present?
    return if booking&.skip_stock_check || SystemSetting.stock_allocation_at_delivery_enabled?

    available_stock = stock_batches_scope.sum(:quantity_remaining)

    if persisted? && quantity_changed?
      available_stock += quantity_was
    end

    if quantity > available_stock
      store_label = booking_store_id.present? ? 'in this store' : 'in stock'
      errors.add(:quantity, "only #{available_stock.to_i} units available #{store_label}")
    end
  end

  def reduce_product_stock
    return unless quantity.present? && product.present?
    # Stock allocation deferred to delivery/franchise-assignment time (see
    # Booking#allocate_inventory_at_delivery) — nothing to reduce yet.
    return if SystemSetting.stock_allocation_at_delivery_enabled?

    current_stock = stock_batches_scope.sum(:quantity_remaining)
    remaining_to_allocate = quantity.to_f
    total_allocated = 0.0
    last_batch = nil

    stock_batches_scope.each do |batch|
      break if remaining_to_allocate <= 0

      if batch.quantity_remaining > 0
        allocation = [remaining_to_allocate, batch.quantity_remaining].min
        batch.quantity_remaining -= allocation
        remaining_to_allocate -= allocation
        total_allocated += allocation
        batch.status = 'exhausted' if batch.quantity_remaining <= 0
        batch.save!
        last_batch = batch

        Rails.logger.info "Allocated #{allocation} units from Batch ##{batch.id} (store: #{batch.store_id.inspect})"
      end
    end

    # Non-admin channels (skip_stock_check) are allowed to oversell: push the
    # unmet shortfall onto a batch as negative remaining stock instead of
    # leaving it unallocated, so product.stock actually reflects the deficit.
    if remaining_to_allocate > 0 && booking&.skip_stock_check
      overflow_batch = last_batch || stock_batches_scope.last || product.stock_batches.order(:batch_date, :created_at).last
      if overflow_batch
        # update_columns (not save!) because this deliberately pushes
        # quantity_remaining negative to record the oversell/pre-booking
        # deficit — StockBatch's own `quantity_remaining >= 0` validation
        # would otherwise raise here for exactly the 0-stock case this
        # branch exists to handle (e.g. a Pre Booking order).
        overflow_batch.update_columns(
          quantity_remaining: overflow_batch.quantity_remaining - remaining_to_allocate,
          status: 'exhausted'
        )
      end
      total_allocated += remaining_to_allocate
      remaining_to_allocate = 0
    end

    # new_stock is the post-allocation total for this same (possibly
    # store-scoped) query — computable in Ruby from what was just allocated
    # instead of re-querying with .reload.sum. product.total_batch_stock is a
    # DIFFERENT (always all-store) aggregate used for the denormalized
    # products.stock column; when this allocation wasn't store-scoped to
    # begin with, the two are the same number and total_batch_stock's own
    # query can be skipped too.
    new_stock = current_stock - total_allocated
    new_total_batch_stock = booking_store_id.present? ? product.total_batch_stock : new_stock
    product.update_column(:stock, new_total_batch_stock)

    store_note = booking_store_id.present? ? " at #{booking.store.name}" : ''
    # save!(validate: false): a skip_stock_check (e.g. Pre Booking) order can
    # legitimately push stock_after negative — StockMovement's own
    # `stock_after >= 0` validation would otherwise raise here and abort the
    # whole booking save (see the overflow_batch fix above for the same
    # reasoning).
    product.stock_movements.new(
      reference_type: 'booking',
      reference_id: booking.id,
      movement_type: 'consumed',
      quantity: -quantity.to_f,
      stock_before: current_stock,
      stock_after: new_stock,
      notes: "Stock consumed for booking#{store_note}: #{product.name} (Qty: #{quantity})"
    ).save!(validate: false)

    Rails.logger.info "Reduced stock for Product ##{product.id} by #{quantity}. New store stock: #{new_stock}"
  end

  def handle_quantity_change
    return unless quantity_previously_changed? && product.present?
    return if SystemSetting.stock_allocation_at_delivery_enabled?

    old_quantity = quantity_previously_was || 0
    new_quantity = quantity
    quantity_difference = new_quantity - old_quantity
    current_stock = stock_batches_scope.sum(:quantity_remaining)
    net_change = 0.0

    if quantity_difference > 0
      remaining_to_allocate = quantity_difference.to_f
      last_batch = nil

      stock_batches_scope.each do |batch|
        break if remaining_to_allocate <= 0

        if batch.quantity_remaining > 0
          allocation = [remaining_to_allocate, batch.quantity_remaining].min
          batch.quantity_remaining -= allocation
          remaining_to_allocate -= allocation
          net_change -= allocation
          batch.status = 'exhausted' if batch.quantity_remaining <= 0
          batch.save!
          last_batch = batch
        end
      end

      # See reduce_product_stock for why non-admin channels overflow negative
      # instead of leaving the increase unallocated.
      if remaining_to_allocate > 0 && booking&.skip_stock_check
        overflow_batch = last_batch || stock_batches_scope.last || product.stock_batches.order(:batch_date, :created_at).last
        if overflow_batch
          # update_columns (not save!) — see reduce_product_stock for why.
          overflow_batch.update_columns(
            quantity_remaining: overflow_batch.quantity_remaining - remaining_to_allocate,
            status: 'exhausted'
          )
        end
        net_change -= remaining_to_allocate
        remaining_to_allocate = 0
      end
    elsif quantity_difference < 0
      quantity_to_restore = quantity_difference.abs.to_f

      restore_scope = booking_store_id.present? \
        ? product.stock_batches.where(store_id: booking_store_id).order(:batch_date, :created_at) \
        : product.stock_batches.order(:batch_date, :created_at)

      restore_scope.reverse_each do |batch|
        break if quantity_to_restore <= 0

        if batch.status == 'exhausted'
          batch.quantity_remaining += quantity_to_restore
          batch.status = 'active'
          batch.save!
          net_change += quantity_to_restore
          break
        elsif batch.status == 'active'
          batch.quantity_remaining += quantity_to_restore
          batch.save!
          net_change += quantity_to_restore
          break
        end
      end
    end

    # See reduce_product_stock for why this avoids a .reload.sum round trip.
    new_stock = current_stock + net_change
    new_total_batch_stock = booking_store_id.present? ? product.total_batch_stock : new_stock
    product.update_column(:stock, new_total_batch_stock)

    # Create stock movement record for the change
    if quantity_difference != 0
      movement_type = quantity_difference > 0 ? 'consumed' : 'adjusted'
      movement_quantity = quantity_difference > 0 ? -quantity_difference.abs : quantity_difference.abs

      # save!(validate: false) — see reduce_product_stock for why.
      product.stock_movements.new(
        reference_type: 'booking',
        reference_id: booking.id,
        movement_type: movement_type,
        quantity: movement_quantity,
        stock_before: current_stock,
        stock_after: new_stock,
        notes: "Booking item quantity changed from #{old_quantity} to #{new_quantity}"
      ).save!(validate: false)
    end
  end

  def restore_product_stock
    return unless quantity.present? && product.present?
    return if SystemSetting.stock_allocation_at_delivery_enabled?

    current_stock = stock_batches_scope.sum(:quantity_remaining)
    quantity_to_restore = quantity.to_f
    net_change = 0.0

    restore_scope = booking_store_id.present? \
      ? product.stock_batches.where(store_id: booking_store_id).order(:batch_date, :created_at) \
      : product.stock_batches.order(:batch_date, :created_at)

    restore_scope.reverse_each do |batch|
      break if quantity_to_restore <= 0

      if batch.status == 'exhausted'
        batch.quantity_remaining += quantity_to_restore
        batch.status = 'active'
        batch.save!
        net_change += quantity_to_restore
        break
      elsif batch.status == 'active'
        batch.quantity_remaining += quantity_to_restore
        batch.save!
        net_change += quantity_to_restore
        break
      end
    end

    # See reduce_product_stock for why this avoids a .reload.sum round trip.
    new_stock = current_stock + net_change
    new_total_batch_stock = booking_store_id.present? ? product.total_batch_stock : new_stock
    product.update_column(:stock, new_total_batch_stock)

    # save!(validate: false) — see reduce_product_stock for why (stock_after
    # can still be negative here if the product's stock was already in
    # deficit from an earlier oversold/pre-booked item).
    product.stock_movements.new(
      reference_type: 'booking',
      reference_id: booking.id,
      movement_type: 'adjusted',
      quantity: quantity.to_f,
      stock_before: current_stock,
      stock_after: new_stock,
      notes: "Stock restored from cancelled booking item: #{product.name} (Qty: #{quantity})"
    ).save!(validate: false)

    Rails.logger.info "Restored stock for Product ##{product.id} by #{quantity}. New stock: #{new_stock}"
  end

  def booking_store_id
    booking&.store_id
  end

  def stock_batches_scope
    if booking_store_id.present?
      product.stock_batches.active.where(store_id: booking_store_id).order(:batch_date, :created_at)
    else
      product.stock_batches.active.order(:batch_date, :created_at)
    end
  end
end
