module ConfigurablePagination
  extend ActiveSupport::Concern

  private

  # Cached: this concern is included by 13+ index actions, each of which was
  # paying its own ~250-300ms round trip to the remote DB for the exact same
  # setting on every single page load. Busted in Admin::Settings::SystemController#update
  # when the value actually changes.
  def default_per_page
    Rails.cache.fetch('system_setting/default_pagination_per_page', expires_in: 5.minutes) do
      SystemSetting.default_pagination_per_page
    end
  end

  def per_page_param
    # Allow users to override via URL parameter, but limit to reasonable bounds
    per_page = params[:per_page].to_i
    return default_per_page if per_page <= 0

    # Limit between 5 and 100, default to system setting if out of bounds
    [[per_page, 5].max, 100].min
  end

  def paginate_records(records)
    per_page = per_page_param
    total_count = records.count

    # Store total count and per_page for view access
    @total_record_count = total_count
    @items_per_page = per_page
    @show_pagination = total_count > per_page

    # Only apply pagination if needed
    if @show_pagination
      records.page(params[:page]).per(per_page)
    else
      # Return all records without pagination if count is less than or equal to items per page
      records.page(1).per(total_count > 0 ? total_count : 1)
    end
  end

  # Helper method to check if pagination should be shown
  def should_show_pagination?(records = nil)
    if records
      total = records.respond_to?(:total_count) ? records.total_count : records.count
      total > per_page_param
    else
      @show_pagination
    end
  end
end