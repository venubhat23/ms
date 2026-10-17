class StoreAdmin::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  skip_load_and_authorize_resource if respond_to?(:skip_load_and_authorize_resource)
  before_action :authenticate_user!
  before_action :ensure_store_admin_access
  before_action :set_current_store
  layout 'store_admin'

  # current_user.primary_store is a DB round trip on every single store_admin
  # request (see config/initializers/warm_db_connections.rb for why that round
  # trip is expensive here — a remote, cross-region Postgres). Store
  # assignment changes are rare admin actions, so a short-lived in-process
  # cache (mirrors the pattern in HomeController) trades a bounded staleness
  # window for skipping that round trip on every request but the first per TTL.
  PRIMARY_STORE_LOCAL_TTL = 30.seconds

  @primary_store_cache = {}
  @primary_store_mutex = Mutex.new

  class << self
    attr_accessor :primary_store_cache
    attr_reader :primary_store_mutex
  end

  protected

  def ensure_store_admin_access
    return if current_user&.store_admin? || current_user&.super_admin? || admin_viewer?

    redirect_to root_path, alert: 'Access denied. Store admin privileges required.'
  end

  def set_current_store
    @current_store = admin_viewing_store || cached_primary_store
    return if @current_store

    if admin_viewer?
      # Admins have no store of their own: send them back to pick one.
      redirect_to admin_stores_path, alert: 'Choose a store and click "View Store Dashboard" to open its dashboard.'
    else
      redirect_to root_path, alert: 'No store assigned. Please contact administrator.'
    end
  end

  # An admin previewing a store via Admin > Stores > "View Store Dashboard".
  def admin_viewer?
    current_user&.admin? || current_user&.super_admin?
  end

  # The store an admin chose to view (Admin::StoresController#view_as_store_admin).
  def admin_viewing_store
    return unless admin_viewer? && session[:admin_viewing_store_id].present?

    @admin_viewing_store ||= Store.find_by(id: session[:admin_viewing_store_id])
  end
  helper_method :admin_viewing_store

  def store_admin_sidebar_permissions
    return @store_admin_permissions if defined?(@store_admin_permissions)
    @store_admin_permissions = {
      'dashboard' => true,
      'bookings' => current_user.can_create_bookings?,
      'expenses' => true
    }
  end

  helper_method :store_admin_sidebar_permissions

  private

  def cached_primary_store
    now   = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    # Explicit receiver: class-level ivars aren't inherited, so self.class
    # (e.g. StoreAdmin::DashboardController) would see nil here.
    cache = StoreAdmin::ApplicationController.primary_store_cache
    entry = cache[current_user.id]
    return entry[:store] if entry && entry[:expires_at] > now

    StoreAdmin::ApplicationController.primary_store_mutex.synchronize do
      entry = cache[current_user.id]
      next entry[:store] if entry && entry[:expires_at] > now

      store = current_user.primary_store
      cache[current_user.id] = { store: store, expires_at: now + PRIMARY_STORE_LOCAL_TTL }
      store
    end
  end
end
