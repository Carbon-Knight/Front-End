class CarMonthlyMileagesController < ApplicationController
  before_action :require_user

  def new
    @cars = CarsFacade.get_cars(current_user)
  end
end
