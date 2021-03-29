class CarMonthlyMileageFacade
  class << self
    def get_car_monthly_mileages(current_user)
      car_monthly_mileages = CarMonthlyMileageService.get_car_monthly_mileages(current_user)
      car_monthly_mileages.map do |car_monthly_mileage|
        CarMonthlyMileage.new(car_monthly_mileage)
      end
    end

    def car_monthly_mileage_by_id(cmm_id)
      CarMonthlyMileage.new(CarMonthlyMileageService.get_car_monthly_mileage_by_id(cmm_id))
    end

    def update_car_monthly_mileage(car_monthly_mileage_id, footprint_params)
      CarMonthlyMileageService.update_car_monthly_mileage(car_monthly_mileage_id, footprint_params)
    end
  end
end
