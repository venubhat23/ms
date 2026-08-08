class Storefront::BaseController < ApplicationController
  # Public/anonymous storefront — no Devise auth, no CanCan, no customer login.
  # Mirrors Customer::BaseController's skips minus the customer authentication.
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  skip_before_action :set_cache_control_headers
  skip_before_action :ensure_session_security
  layout false

  protected

  def should_authorize?
    false
  end

  def mobile_api?
    true
  end

  # The cookie session store round-trips through JSON, which turns the
  # `items:` symbol key (and nested item-hash keys) into strings on every
  # request after the first — .with_indifferent_access keeps :items/'items'
  # interchangeable across that round trip instead of silently losing the cart.
  def initialize_cart
    session[:cart] ||= { 'items' => [] }
    @cart = session[:cart].with_indifferent_access
  end

  def save_cart
    session[:cart] = @cart
  end

  def cart_items
    @cart[:items] || []
  end

  def cart_count
    return 0 unless session[:cart].present? && session[:cart][:items].present?
    session[:cart][:items].sum { |item| item['quantity'].to_i }
  end

  def cart_total
    cart_items.sum { |item| item['price'].to_f * item['quantity'].to_f }
  end

  helper_method :cart_count, :cart_total, :cart_items
end
