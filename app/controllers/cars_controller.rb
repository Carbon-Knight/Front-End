class CarsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    CarsFacade.new_car(new_car_params, current_user)
    redirect_to "/car_monthly_mileages/new"
  end

  private

  def new_car_params
    params.permit(:make, :model, :year, :mpg, :fuel_type)
  end
end
