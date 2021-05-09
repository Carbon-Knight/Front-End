class Car
  attr_reader :car_id, 
              :make,
              :model,
              :year,
              :mpg,
              :fuel_type

  def initialize(car_info)
    @car_id = car_info[:id] if car_info.present? && car_info[:id]
    @make = car_info[:make] if car_info.present? && car_info[:make]
    @model = car_info[:model] if car_info.present? && car_info[:model]
    @year = car_info[:year] if car_info.present? && car_info[:year]
    @mpg = car_info[:mpg] if car_info.present? && car_info[:mpg]
    @fuel_type = car_info[:fuelType] if car_info.present? && car_info[:fuelType]
  end
end
