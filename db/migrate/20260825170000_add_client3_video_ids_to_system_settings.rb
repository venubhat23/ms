class AddClient3VideoIdsToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :client3_video1_id, :string
    add_column :system_settings, :client3_video2_id, :string
    add_column :system_settings, :client3_video3_id, :string
  end
end
