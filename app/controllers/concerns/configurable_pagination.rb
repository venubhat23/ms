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

  def paginate_records(records, total_count: nil)
    per_page = per_page_param

    # Paginate first and read total_count off the SAME relation, instead of
    # issuing a separate records.count beforehand. Kaminari memoizes
    # total_count per relation instance, so this reuses the one COUNT query
    # for both @total_record_count here and any later `paginate`/total_count
    # calls in the view, cutting a redundant round trip to the (remote) DB.
    paginated = records.page(params[:page]).per(per_page)

    if total_count
      # Caller already computed COUNT(*) for this exact filtered scope (e.g.
      # bundled into a stats aggregate query it needed anyway) — seed
      # Kaminari's memo so neither this method nor the view's `paginate`
      # helper issues its own COUNT query for the same number.
      paginated.instance_variable_set(:@total_count, total_count)
    else
      total_count = paginated.total_count
    end

    # Store total count and per_page for view access
    @total_record_count = total_count
    @items_per_page = per_page
    @show_pagination = total_count > per_page

    paginated
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