class CarsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    if missing_params?
      flash.now[:error] = 'Missing fields'
      render cars_new_path
    else
      CarsFacade.new_car(new_car_params, current_user)
      redirect_to "/car_monthly_mileages/new"
    end
  end

  def missing_params?
    new_car_params[:make] == "" || new_car_params[:model] == "" ||
    new_car_params[:year] == "" || new_car_params[:mpg] == "" ||
    new_car_params[:fuel_type] == "Select Fuel Type"
  end

  private

  def new_car_params
    params.permit(:make, :model, :year, :mpg, :fuel_type)
  end
end
