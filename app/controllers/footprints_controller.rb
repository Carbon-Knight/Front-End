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
    footprint_id = params[:id].to_i
    footprints = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
    @footprint = footprints.find do |footprint|
      footprint.id == footprint_id
    end
  end

  def update
    # footprints = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
    # footprint = footprints.find do |footprint|
    #   footprint.id == params[:id].to_i
    # end

    # new_mileage = params[:total_mileage]
    # params[:id].to_i

    # require 'pry', binding.pry
    if params[:total_mileage] == ''
      flash.now[:error] = 'You need to fill in the new total mileage'
      render edit_footprint_path
    else
      CarMonthlyMileageFacade.update_footprint(new_footprint_params, current_user)
      redirect_to footprints_path
    end
  end

  private

  def new_footprint_params
    params.permit(:car_id, :total_mileage, :month, :year)
  end
end
