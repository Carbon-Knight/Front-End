class CarsFacade
  def self.new_car(car_params, current_user)
    CarService.new_car(car_params, current_user)
  end

  def self.get_cars(current_user)
    cars = CarService.get_cars(current_user)
    unless cars.nil?
      # TODO: Create error message for when this happens
      cars.map do |car|
        Car.new(car)
      end
    end
  end
end
