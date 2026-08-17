# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # If user has no role, grant minimal access
    unless user.role
      grant_guest_abilities(user)
      return
    end

    # Role-based permissions
    grant_role_based_abilities(user)

    # Common abilities for all authenticated users
    if user.persisted?
      can :read, :dashboard
      can [:show, :edit, :update], User, id: user.id
    end
  end

  private

  def grant_guest_abilities(user)
    if user.persisted?
      can :read, :dashboard
      can [:show, :edit, :update], User, id: user.id
    end
  end

  def grant_role_based_abilities(user)
    # Special handling for super admin
    if user.role == 'super_admin' || user.admin?
      can :manage, :all
      return
    end

    # Use sidebar permissions for authorization
    if user.has_sidebar_permission?('dashboard')
      can :read, :dashboard
    end

    if user.has_sidebar_permission?('customers')
      can :manage, Customer
    end

    if user.has_sidebar_permission?('bookings')
      can :manage, Booking
      can :manage, Order
    end

    if user.has_sidebar_permission?('products')
      can :manage, Product
    end

    if user.has_sidebar_permission?('categories')
      can :manage, Category
    end

    if user.has_sidebar_permission?('vendors')
      can :manage, Vendor
    end

    if user.has_sidebar_permission?('vendor_purchases')
      can :manage, VendorPurchase
    end

    if user.has_sidebar_permission?('reports')
      can :read, :reports
      can :all, Admin::ReportsController
    end

    if user.has_sidebar_permission?('invoices')
      can :manage, Invoice
      can :manage, BookingInvoice
    end

    if user.has_sidebar_permission?('notes')
      can :manage, Note
    end

    if user.has_sidebar_permission?('delivery_people')
      can :manage, DeliveryPerson
    end

    if user.has_sidebar_permission?('franchises')
      can :manage, Franchise
    end

    if user.has_sidebar_permission?('affiliates')
      can :manage, Affiliate
    end

    if user.has_sidebar_permission?('subscriptions')
      can :manage, MilkSubscription
    end

    if user.has_sidebar_permission?('customer_formats')
      can :manage, CustomerFormat
    end

    if user.has_sidebar_permission?('imports')
      can :import, :all
      can :export, :all
    end

    if user.has_sidebar_permission?('system_settings')
      can :manage, :settings
      can :manage, SystemSetting
    end

    if user.has_sidebar_permission?('user_roles')
      can :manage, User
      can :manage, Role
    end

    if user.has_sidebar_permission?('banners')
      can :manage, Banner
    end

    if user.has_sidebar_permission?('client_requests')
      can :manage, ClientRequest
    end

    if user.has_sidebar_permission?('stores')
      can :manage, Store
    end

    if user.has_sidebar_permission?('coupons')
      can :manage, Coupon
    end

    if user.has_sidebar_permission?('customer_wallets')
      can :manage, CustomerWallet
    end
  end

end
