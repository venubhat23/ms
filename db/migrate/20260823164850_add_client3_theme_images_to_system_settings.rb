class AddClient3ThemeImagesToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :client3_hero_images, :text
    add_column :system_settings, :client3_story_image_url, :string
    add_column :system_settings, :client3_testimonial1_image_url, :string
    add_column :system_settings, :client3_testimonial2_image_url, :string
  end
end
