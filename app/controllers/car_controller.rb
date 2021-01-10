class CarController < ApplicationController
  def new
    @user = current_user
  end

  def create
    CarFacade.new_car(new_car_params)
    # TODO
    # before redirect, send params to facade/service to make a graphql mutation query
    # to save car into backend db
    # respond with new car data
    redirect_to "/car_monthly_mileages/new"
  end

  private 

  def new_car_params
    params.permit(:make, :model, :year, :fuel_efficiency, :fuel_type)
  end
end
