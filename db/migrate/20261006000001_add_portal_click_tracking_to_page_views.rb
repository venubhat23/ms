class AddPortalClickTrackingToPageViews < ActiveRecord::Migration[8.0]
  # Widens page_views from "public storefront page loads" to every portal
  # (store, customer, affiliate, franchise, store admin, admin) and adds the
  # browser-side events the tracking beacon sends:
  #   kind     'view' (page load, server side) | 'click' | 'leave' (time on page)
  #   section  which portal the page belongs to
  #   user_*   who was logged in (no names stored; resolved on the dashboard)
  #   label    clicked element's text; target = where the click pointed
  #   duration seconds the page was visible ('leave' rows only)
  disable_ddl_transaction!

  def up
    return unless table_exists?(:page_views)

    add_column :page_views, :kind, :string, limit: 8, null: false, default: "view", if_not_exists: true
    add_column :page_views, :section, :string, limit: 16, null: false, default: "store", if_not_exists: true
    add_column :page_views, :user_type, :string, limit: 16, if_not_exists: true
    add_column :page_views, :user_id, :bigint, if_not_exists: true
    add_column :page_views, :label, :string, limit: 120, if_not_exists: true
    add_column :page_views, :target, :string, if_not_exists: true
    add_column :page_views, :duration, :integer, if_not_exists: true

    # Visitor / user journey lookups on the dashboard.
    add_index :page_views, [:visitor_id, :visited_at], algorithm: :concurrently, if_not_exists: true
    add_index :page_views, [:user_type, :user_id, :visited_at], where: "user_id IS NOT NULL",
              algorithm: :concurrently, if_not_exists: true
  end

  def down
    remove_index :page_views, [:user_type, :user_id, :visited_at], if_exists: true
    remove_index :page_views, [:visitor_id, :visited_at], if_exists: true
    %i[kind section user_type user_id label target duration].each do |col|
      remove_column :page_views, col, if_exists: true
    end
  end
end
