# Moves a booking to a new stage the same way the web admin "Manage Stage"
# page does (Admin::BookingsController#update_stage), for the admin mobile
# API (PATCH /api/v1/mobile/admin/bookings/:id/update_stage).
#
# Like the web page, any stage other than the current one may be picked —
# it is not limited to Booking#next_possible_statuses. Special cases match
# the web exactly:
#   * 'paid'      — pseudo-stage for pre-bookings; marks payment fully paid.
#   * 'confirmed' on a pending pre-booking — approve_pre_booking! (emails customer).
#   * 'out_for_delivery' — assigns a delivery person or (when enabled) a
#     franchise; one-time only, and a franchise assignment moves stock via
#     FranchiseDeliveryAssignmentService.
#
# Returns a Result; never raises for user errors.
class BookingStageUpdateService
  Result = Struct.new(:success, :message, keyword_init: true) do
    def success? = success
  end

  def self.stages_for(booking)
    all = if booking.is_pre_booking?
            %w[ordered_and_delivery_pending confirmed paid processing packed shipped out_for_delivery delivered completed cancelled returned]
          else
            %w[draft ordered_and_delivery_pending confirmed processing packed shipped out_for_delivery delivered completed cancelled returned]
          end
    all.reject { |s| s == booking.status || (s == 'paid' && booking.payment_status_paid?) }
  end

  def self.franchise_delivery_enabled?
    SystemSetting.franchise_commission_enabled? && SystemSetting.franchise_delivery_assignment_enabled?
  end

  def initialize(booking:, target_stage:, actor:, params:)
    @booking = booking
    @target_stage = target_stage.to_s
    @actor = actor
    @params = params
  end

  def call
    return failure('Please select a target stage.') if @target_stage.blank?
    unless self.class.stages_for(@booking).include?(@target_stage)
      return failure("Cannot move booking from #{@booking.status.humanize} to #{@target_stage.humanize}.")
    end

    if @target_stage == 'paid'
      @booking.mark_as_fully_paid!
      return success("Booking ##{@booking.booking_number} marked as fully paid.")
    end

    if @target_stage == 'confirmed' && @booking.pending_pre_booking_approval?
      @booking.approve_pre_booking!
      return success("Pre-booking ##{@booking.booking_number} approved — customer notified.")
    end

    transition_data = build_transition_data

    if @target_stage == 'out_for_delivery' && (@booking.delivery_franchise_id.present? || @booking.delivery_person_id.present?)
      assignee = @booking.delivery_franchise&.name || @booking.delivery_person&.full_name || 'someone'
      return failure("This booking has already been assigned to #{assignee} for delivery.")
    end

    franchise = nil
    if transition_data[:delivery_mode] == 'franchise'
      franchise = Franchise.active.find_by(id: transition_data[:delivery_franchise_id])
      return failure('Please select a valid franchise.') unless franchise
    end

    if @target_stage == 'out_for_delivery' && transition_data[:delivery_mode] == 'delivery_person' &&
       transition_data[:delivery_person_id].present? &&
       !DeliveryPerson.active.exists?(id: transition_data[:delivery_person_id])
      return failure('Please select a valid delivery person.')
    end

    ActiveRecord::Base.transaction do
      if franchise
        FranchiseDeliveryAssignmentService.new(
          booking: @booking, franchise: franchise, actor: @actor, transition_data: transition_data
        ).call!
      else
        apply_transition!(transition_data)
      end
    end

    if franchise
      success("Franchise #{franchise.name} assigned and booking updated successfully.")
    else
      success("Booking stage updated to #{@target_stage.humanize} successfully.")
    end
  rescue ActiveRecord::RecordInvalid => e
    failure("Failed to update stage: #{e.record.errors.full_messages.join(', ')}")
  rescue => e
    Rails.logger.error "BookingStageUpdateService: #{e.class}: #{e.message}"
    Rails.logger.error e.backtrace.first(20).join("\n")
    failure("Failed to update stage: #{e.message}")
  end

  private

  def val(key) = @params[key].presence

  def success(msg) = Result.new(success: true, message: msg)
  def failure(msg) = Result.new(success: false, message: msg)

  def build_transition_data
    data = {
      from_stage: @booking.status,
      to_stage: @target_stage,
      timestamp: Time.current,
      user_id: @actor.id,
      user_name: @actor.try(:full_name).presence || @actor.email
    }

    case @target_stage
    when 'shipped'
      data[:courier_service] = val(:courier_service)
      data[:tracking_number] = val(:tracking_number)
      data[:shipping_charges] = val(:shipping_charges)
      data[:expected_delivery_date] = val(:expected_delivery_date)
    when 'out_for_delivery'
      franchise_mode = @params[:delivery_mode].to_s == 'franchise' && self.class.franchise_delivery_enabled?
      data[:delivery_mode] = franchise_mode ? 'franchise' : 'delivery_person'
      if franchise_mode
        data[:delivery_franchise_id] = val(:delivery_franchise_id)
      else
        data[:delivery_person_id] = val(:delivery_person_id)
        dp = DeliveryPerson.find_by(id: data[:delivery_person_id]) if data[:delivery_person_id]
        data[:delivery_person] = val(:delivery_person) || dp&.full_name
        data[:delivery_contact] = val(:delivery_contact) || dp&.mobile
      end
    when 'delivered'
      data[:delivery_person] = val(:delivery_person)
      data[:delivery_time] = val(:delivery_time)
      data[:customer_satisfaction] = val(:customer_satisfaction)
    when 'cancelled'
      data[:cancellation_reason] = val(:cancellation_reason)
      data[:refund_amount] = val(:refund_amount)
    when 'returned'
      data[:return_reason] = val(:return_reason)
      data[:refund_amount] = val(:refund_amount)
    end

    data[:notes] = val(:transition_notes) if val(:transition_notes)
    data
  end

  # Same field writes as Admin::BookingsController#update_booking_with_stage_transition.
  def apply_transition!(data)
    b = @booking
    b.status = @target_stage

    case @target_stage
    when 'shipped'
      b.tracking_number = data[:tracking_number] if data[:tracking_number].present?
      b.shipping_charges = data[:shipping_charges] if data[:shipping_charges].present?
      b.expected_delivery_date = data[:expected_delivery_date] if data[:expected_delivery_date].present?
      b.courier_service = data[:courier_service] if data[:courier_service].present?
    when 'delivered'
      b.delivery_time = data[:delivery_time] if data[:delivery_time].present?
      b.customer_satisfaction = data[:customer_satisfaction] if data[:customer_satisfaction].present?
      # delivery_person is both an association and a string column; write the column.
      b.write_attribute(:delivery_person, data[:delivery_person]) if data[:delivery_person].present?
    when 'cancelled'
      b.cancellation_reason = data[:cancellation_reason] if data[:cancellation_reason].present?
      b.refund_amount = data[:refund_amount] if data[:refund_amount].present?
    when 'returned'
      b.return_reason = data[:return_reason] if data[:return_reason].present?
      b.refund_amount = data[:refund_amount] if data[:refund_amount].present?
    when 'out_for_delivery'
      b.delivery_mode = data[:delivery_mode] if data[:delivery_mode].present?
      b.write_attribute(:delivery_person, data[:delivery_person]) if data[:delivery_person].present?
      b.delivery_contact = data[:delivery_contact] if data[:delivery_contact].present?
      b.delivery_person_id = data[:delivery_person_id] if data[:delivery_person_id].present?
    end

    history = begin
      b.stage_history.present? ? JSON.parse(b.stage_history) : []
    rescue JSON::ParserError
      []
    end
    history << data.stringify_keys
    b.stage_history = history.to_json
    b.stage_updated_at = Time.current
    b.stage_updated_by = @actor.id
    b.transition_notes = [b.transition_notes, data[:notes]].compact.join("\n---\n") if data[:notes].present?

    b.save!
  end
end
