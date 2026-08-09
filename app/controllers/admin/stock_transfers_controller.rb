class Admin::StockTransfersController < Admin::ApplicationController
  before_action { require_sidebar_permission!('stock_transfers') }
  before_action :set_transfer, only: [:show, :approve, :reject]

  # A single "request" (transfer_group_id) can contain hundreds of product
  # line-items — rendering them all inline is what actually breaks the page.
  # The index only shows one representative row per group (for header info);
  # the full item list is fetched on demand into a modal via group_items.
  GROUP_ITEM_INLINE_LIMIT = 1

  def index
    base_scope = StockTransfer.all
    base_scope = base_scope.where(status: params[:status]) if params[:status].present?

    # Paginate by request-group, not raw row, so a multi-product request never
    # gets split across pages. Determine group order with one aggregate query
    # (MAX(created_at) per group) instead of hydrating every row in the table.
    group_key_expr = "COALESCE(transfer_group_id, 'single_' || id::text)"
    group_keys_ordered = base_scope
                         .select("#{group_key_expr} AS group_key")
                         .group(group_key_expr)
                         .order(Arel.sql('MAX(created_at) DESC'))
                         .map(&:group_key)

    per_page = SystemSetting.default_pagination_per_page || 20
    paged_keys = Kaminari.paginate_array(group_keys_ordered).page(params[:page]).per(per_page)

    real_group_ids = paged_keys.reject { |k| k.start_with?('single_') }
    single_ids     = paged_keys.select { |k| k.start_with?('single_') }.map { |k| k.delete_prefix('single_').to_i }

    # One grouped count query for every group on this page instead of one
    # `.count` round trip per group (previously ~20 serial queries/page).
    group_totals = real_group_ids.any? ? base_scope.where(transfer_group_id: real_group_ids)
                                                     .group(:transfer_group_id).count : {}

    # Status per group must reflect ALL rows in the group, not just the single
    # representative row fetched below for header display — otherwise a group
    # whose most-recent row happens to be resolved would misreport its status.
    group_status_counts = Hash.new { |h, k| h[k] = Hash.new(0) }
    if real_group_ids.any?
      base_scope.where(transfer_group_id: real_group_ids)
                .group(:transfer_group_id, :status).count
                .each { |(gid, status), count| group_status_counts[gid][status] = count }
    end

    # Fetch only the top GROUP_ITEM_INLINE_LIMIT rows per group (by created_at)
    # in a single query via a window function, instead of one query per group
    # (previously the dominant cost — each per-group `.includes` fanned out
    # into ~6 extra queries, multiplied by every group on the page).
    ids_needed = single_ids.dup
    if real_group_ids.any?
      conditions = ['transfer_group_id IN (?)']
      binds      = [real_group_ids]
      if params[:status].present?
        conditions << 'status = ?'
        binds << params[:status]
      end

      ranked_sql = <<~SQL
        SELECT id FROM (
          SELECT id, ROW_NUMBER() OVER (PARTITION BY transfer_group_id ORDER BY created_at DESC) AS rn
          FROM stock_transfers
          WHERE #{conditions.join(' AND ')}
        ) ranked
        WHERE rn <= ?
      SQL
      sanitized = ActiveRecord::Base.sanitize_sql_array([ranked_sql, *binds, GROUP_ITEM_INLINE_LIMIT])
      ids_needed += ActiveRecord::Base.connection.select_values(sanitized).map(&:to_i)
    end

    # Single query (+ preload queries for the includes) for every transfer
    # shown on the page, instead of one query-with-includes per group.
    transfers_by_id    = StockTransfer.includes(:product, :product_variant, :from_store, :to_store, :requested_by, :approved_by)
                                       .where(id: ids_needed)
                                       .index_by(&:id)
    transfers_by_group = transfers_by_id.values.group_by { |t| t.transfer_group_id.presence || "single_#{t.id}" }

    stock_cache = {}

    @groups = paged_keys.filter_map do |key|
      transfers   = (transfers_by_group[key] || []).sort_by { |t| -t.created_at.to_f }
      total_count = key.start_with?('single_') ? transfers.size : (group_totals[key] || 0)
      next if transfers.empty?

      # Pre-compute available stock per (product_id, from_store_id) to avoid N+1 — only for what's shown
      transfers.each do |t|
        ck = [t.product_id, t.from_store_id]
        stock_cache[ck] ||= StockBatch.available_for_product(t.product_id, store_id: t.from_store_id)
                                       .sum(:quantity_remaining)
      end

      statuses = key.start_with?('single_') ? transfers.map(&:status) : group_status_counts[key].keys

      {
        group_id:     key,
        transfers:    transfers,
        total_count:  total_count,
        status:       group_status(statuses),
        from_store:   transfers.first.from_store_name,
        to_store:     transfers.first.to_store&.name,
        requested_by: transfers.first.requested_by,
        created_at:   transfers.first.created_at,
        notes:        transfers.first.notes,
        stock_cache:  stock_cache
      }
    end

    @page_data = paged_keys
    @pending_count = StockTransfer.pending.count
  end

  # Full, paginated item list for a single request (transfer_group_id) —
  # linked from the index when a group has more items than fit inline.
  def show_group
    @group_id = params[:group_id]
    per_page = SystemSetting.default_pagination_per_page || 20

    scope = StockTransfer.includes(:product, :product_variant, :from_store, :to_store, :requested_by, :approved_by)
                          .where(transfer_group_id: @group_id)
                          .order(created_at: :desc)
    @transfers = scope.page(params[:page]).per(per_page)

    if @transfers.empty?
      redirect_to admin_stock_transfers_path, alert: 'Transfer request not found.' and return
    end

    stock_cache = {}
    @transfers.each do |t|
      key = [t.product_id, t.from_store_id]
      stock_cache[key] ||= StockBatch.available_for_product(t.product_id, store_id: t.from_store_id)
                                     .sum(:quantity_remaining)
    end
    @stock_cache  = stock_cache
    first         = @transfers.first
    @status       = group_status(StockTransfer.where(transfer_group_id: @group_id).pluck(:status))
    @from_store   = first.from_store_name
    @to_store     = first.to_store&.name
    @requested_by = first.requested_by
    @created_at   = first.created_at
    @notes        = first.notes
  end

  def show
  end

  # Full item list for a single request (transfer_group_id), rendered as an
  # HTML fragment for the "View items" modal on the index page.
  def group_items
    transfers = StockTransfer.includes(:product, :product_variant, :from_store, :to_store, :requested_by, :approved_by)
                              .where(transfer_group_id: params[:group_id])
                              .order(created_at: :desc)
                              .to_a

    if transfers.empty?
      render plain: 'Transfer request not found.', status: :not_found
      return
    end

    stock_cache = {}
    transfers.each do |t|
      key = [t.product_id, t.from_store_id]
      stock_cache[key] ||= StockBatch.available_for_product(t.product_id, store_id: t.from_store_id)
                                     .sum(:quantity_remaining)
    end

    render partial: 'items_table', locals: { transfers: transfers, stock_cache: stock_cache }
  end

  def approve
    @transfer.approve!(current_user)
    flash[:notice] = "Transfer approved. #{@transfer.quantity} units of #{@transfer.product.name} moved to #{@transfer.to_store.name}."
    redirect_to admin_stock_transfers_path
  rescue => e
    flash[:alert] = "Approval failed: #{e.message}"
    redirect_to admin_stock_transfer_path(@transfer)
  end

  def reject
    reason = params[:rejection_reason].to_s.strip
    @transfer.reject!(current_user, reason)
    flash[:notice] = 'Transfer request rejected.'
    redirect_to admin_stock_transfers_path
  end

  # Approve all pending transfers in a group. Queued as a background job so a
  # request with many line-items can't hang the web request past the
  # platform timeout. The index page polls bulk_progress with the returned
  # token to show a live percentage while it runs.
  def approve_group
    enqueue_bulk_action([params[:group_id]], 'approve')
  end

  # Reject all pending transfers in a group
  def reject_group
    enqueue_bulk_action([params[:group_id]], 'reject', params[:rejection_reason].to_s.strip)
  end

  # Bulk approve multiple groups at once
  def bulk_approve
    enqueue_bulk_action(Array(params[:group_ids]), 'approve')
  end

  # Bulk reject multiple groups at once
  def bulk_reject
    enqueue_bulk_action(Array(params[:group_ids]), 'reject', params[:rejection_reason].to_s.strip)
  end

  # Polled by the index page's progress bar while a bulk approve/reject job runs.
  def bulk_progress
    progress = Rails.cache.read("stock_transfer_bulk_progress:#{params[:token]}")
    if progress.nil?
      render json: { done: true, missing: true, total: 0, processed: 0, failed: 0, percent: 100 }
      return
    end

    percent = progress[:total].zero? ? 100 : ((progress[:processed].to_f / progress[:total]) * 100).round
    render json: progress.merge(percent: percent)
  end

  private

  def enqueue_bulk_action(group_ids, action, reason = nil)
    group_ids = Array(group_ids).reject(&:blank?)
    return respond_bulk_error('No requests selected.') if group_ids.empty?

    count = StockTransfer.pending.where(transfer_group_id: group_ids).count
    return respond_bulk_error('No pending transfers found for this request.') if count.zero?

    token = SecureRandom.hex(10)
    StockTransferBulkActionJob.perform_later(group_ids, action, current_user.id, reason, token)

    respond_to do |format|
      format.json { render json: { token: token, total: count } }
      format.html do
        verb = action == 'approve' ? 'Approving' : 'Rejecting'
        scope_msg = group_ids.size > 1 ? " across #{group_ids.size} request(s)" : ''
        flash[:notice] = "#{verb} #{count} transfer(s)#{scope_msg} in the background — refresh in a few moments to see the result."
        redirect_to admin_stock_transfers_path
      end
    end
  end

  def respond_bulk_error(message)
    respond_to do |format|
      format.json { render json: { error: message }, status: :unprocessable_entity }
      format.html do
        flash[:alert] = message
        redirect_to admin_stock_transfers_path
      end
    end
  end

  def set_transfer
    @transfer = StockTransfer.find(params[:id])
  end

  def group_status(statuses)
    statuses = statuses.uniq
    return 'pending'   if statuses.include?('pending')
    return 'completed' if statuses.all? { |s| s == 'completed' }
    return 'rejected'  if statuses.all? { |s| s == 'rejected' }
    'partial'
  end
end
