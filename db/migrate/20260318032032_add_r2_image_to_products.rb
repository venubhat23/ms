class AddR2ImageToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :r2_image_url, :string
    add_column :products, :r2_additional_images, :text
  end
end
