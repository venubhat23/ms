class Franchise::InventoryController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled

  def index
    @franchise_inventories = current_franchise.franchise_inventories
                                               .includes(:product)
                                               .references(:product)
                                               .order('products.name')
  end
end
