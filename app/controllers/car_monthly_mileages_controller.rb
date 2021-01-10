class CarMonthlyMileagesController < ApplicationController
  def new
    CarsFacade.get_cars(current_user)
  end
end
