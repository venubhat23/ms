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
    unless current_user&.store_admin? || current_user&.super_admin?
      redirect_to root_path, alert: 'Access denied. Store admin privileges required.'
    end
  end

  def set_current_store
    @current_store = cached_primary_store
    unless @current_store
      redirect_to root_path, alert: 'No store assigned. Please contact administrator.'
    end
  end

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
    cache = self.class.primary_store_cache
    entry = cache[current_user.id]
    return entry[:store] if entry && entry[:expires_at] > now

    self.class.primary_store_mutex.synchronize do
      entry = cache[current_user.id]
      next entry[:store] if entry && entry[:expires_at] > now

      store = current_user.primary_store
      cache[current_user.id] = { store: store, expires_at: now + PRIMARY_STORE_LOCAL_TTL }
      store
    end
  end
end
