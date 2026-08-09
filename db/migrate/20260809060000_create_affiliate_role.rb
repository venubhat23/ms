class CreateAffiliateRole < ActiveRecord::Migration[8.0]
  def up
    return if Role.exists?(name: 'affiliate')

    Role.create!(name: 'affiliate', description: 'Affiliate portal user', status: true)
  end

  def down
    Role.where(name: 'affiliate').destroy_all
  end
end
