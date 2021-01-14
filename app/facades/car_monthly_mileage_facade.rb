class CarMonthlyMileageFacade
  def self.get_car_monthly_mileages(current_user)
    car_monthly_mileages = CarMonthlyMileageService.get_car_monthly_mileages(current_user)
    car_monthly_mileages.map do |car_monthly_mileage|
      CarMonthlyMileage.new(car_monthly_mileage)
    end
  end

  def self.update_car_monthly_mileage(car_monthly_mileage_id, footprint_params, current_user)
    CarMonthlyMileageService.update_car_monthly_mileage(car_monthly_mileage_id, footprint_params, current_user)
  end
end
