class CreatePageViews < ActiveRecord::Migration[8.0]
  # Raw public-storefront hits for Admin > Traffic Analytics. Rows are written
  # in batches by PageViewTracker (never one INSERT per request), and read by
  # one aggregate query per dashboard load, so the only index that matters is
  # the visited_at range scan.
  def change
    return if table_exists?(:page_views)

    create_table :page_views do |t|
      t.datetime :visited_at, null: false
      t.string :path, null: false
      t.string :page, null: false
      t.string :visitor_id, limit: 32, null: false
      t.boolean :new_visitor, null: false, default: false
      t.string :device, limit: 16
      t.string :browser, limit: 32
      t.string :os, limit: 32
      t.string :referrer_host
      t.string :utm_source
      t.string :country
      t.string :region
      t.string :city
    end

    add_index :page_views, :visited_at, include: [:visitor_id]
  end
end
