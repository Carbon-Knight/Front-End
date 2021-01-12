class FootprintsController < ApplicationController
  def new
    @cars = CarsFacade.get_cars(current_user)
  end

  def create
    # TODO: add error messages and render :new
    FootprintFacade.new_footprint(new_footprint_params, current_user)
    #Manually reset cache for year 
    #Rails.cache.delete("params[:year]/footprints")
    
    redirect_to '/dashboard'
  end

  private

  def new_footprint_params
    params.permit(:car_id, :total_mileage, :month, :year)
  end
end
