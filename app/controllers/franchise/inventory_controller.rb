class Franchise::InventoryController < Franchise::BaseController
  def index
    @franchise_inventories = current_franchise.franchise_inventories
                                               .includes(:product)
                                               .references(:product)
                                               .order('products.name')
  end
end
