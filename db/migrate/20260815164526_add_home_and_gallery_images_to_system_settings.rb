class AddHomeAndGalleryImagesToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :home_page_images, :text
    add_column :system_settings, :site_gallery_images, :text
  end
end
