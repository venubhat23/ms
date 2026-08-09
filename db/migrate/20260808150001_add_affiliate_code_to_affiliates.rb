class AddAffiliateCodeToAffiliates < ActiveRecord::Migration[8.0]
  def up
    add_column :affiliates, :affiliate_code, :string

    # Backfill existing affiliates (e.g. ones created via the admin panel
    # before this feature) so they get a referral code too.
    execute <<~SQL
      UPDATE affiliates SET affiliate_code = mobile WHERE affiliate_code IS NULL
    SQL

    add_index :affiliates, :affiliate_code, unique: true
  end

  def down
    remove_index  :affiliates, :affiliate_code
    remove_column :affiliates, :affiliate_code
  end
end
