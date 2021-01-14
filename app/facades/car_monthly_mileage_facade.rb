class CarMonthlyMileageFacade
  def self.get_car_monthly_mileages(current_user)
    car_monthly_mileages = CarMonthlyMileageService.get_car_monthly_mileages(current_user)
    car_monthly_mileages.map do |car_monthly_mileage|
      CarMonthlyMileage.new(car_monthly_mileage)
    end
  end

  def self.update_footprint(footprint_params, current_user)
    # need to pass in the footprint id
    # or the car id?
    require 'pry', binding.pry
  end
end
