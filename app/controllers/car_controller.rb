class CarController < ApplicationController
  def new
    @user = current_user
  end

  def create
    # TODO
    # before redirect, send params to facade/service to make a graphql mutation query
    # to save car into backend db
    # respond with new car data
    redirect_to "/car_monthly_mileages/new"
  end
end
