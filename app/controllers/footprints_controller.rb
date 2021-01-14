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
    Rails.cache.delete("footprint_years/#{current_user.id}/#{Time.now.year}")
    Rails.cache.delete("footprints/#{current_user.id}/#{params[:date][:year]}")
    
    redirect_to '/dashboard'
  end

  private

  def new_footprint_params
    params.permit(:car_id, :total_mileage, :date => [:month, :year])
  end
end
