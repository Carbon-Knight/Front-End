class CarsFacade
  def self.new_car(car_params, current_user)
    CarService.new_car(car_params, current_user)
  end

  def self.get_cars(current_user)
    cars = CarService.get_cars(current_user)
    cars.map do |car|
      Car.new(car)
    end
  end
end
