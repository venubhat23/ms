class AddSplitFeatureEnabledToSystemSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :system_settings, :split_feature_enabled, :boolean, default: false
  end
end
