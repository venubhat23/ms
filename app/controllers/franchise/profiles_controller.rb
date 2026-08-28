class Franchise::ProfilesController < Franchise::BaseController
  def show
    @franchise = current_franchise
  end
end
