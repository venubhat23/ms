class Franchise::InventoryController < Franchise::BaseController
  before_action :ensure_franchise_commission_enabled

  def index
    @franchise_inventories = current_franchise.franchise_inventories
                                               .includes(:product)
                                               .references(:product)
                                               .order('products.name')

    movements = current_franchise.franchise_stock_movements
    @total_credited = movements.where(movement_type: 'added').sum(:quantity)
    @total_debited = movements.where(movement_type: 'consumed').sum(:quantity).abs
    @current_balance = @franchise_inventories.sum(:quantity)

    @stock_movements = movements.includes(:product)
                                 .recent
                                 .page(params[:page])
                                 .per(20)
  end
end
