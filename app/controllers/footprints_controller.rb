class FootprintsController < ApplicationController
  def index
    @car_monthly_mileages = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
  end

  def new
    @cars = CarsFacade.get_cars(current_user)
  end

  def create
    # TODO: add error messages and render :new
    FootprintFacade.new_footprint(new_footprint_params, current_user)
    # Manually reset cache for year
    # Rails.cache.delete("params[:year]/footprints")

    redirect_to '/dashboard'
  end

  def edit
    params[:id]
    # returns id as a string
  end

  private

  def new_footprint_params
    params.permit(:car_id, :total_mileage, :month, :year)
  end
end
