class AddR2ImageToBanners < ActiveRecord::Migration[8.0]
  def change
    add_column :banners, :r2_image_url, :string
  end
end
