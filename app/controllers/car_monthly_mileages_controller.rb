class CarMonthlyMileagesController < ApplicationController
  def new
    @cars = CarsFacade.get_cars(current_user)
  end
end
