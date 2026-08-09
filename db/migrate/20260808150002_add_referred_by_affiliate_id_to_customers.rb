class AddReferredByAffiliateIdToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :referred_by_affiliate_id, :bigint
    add_index  :customers, :referred_by_affiliate_id
  end
end
