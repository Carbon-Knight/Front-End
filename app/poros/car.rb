class Car
  attr_reader :make,
              :model,
              :year,
              :mpg,
              :fuel_type

  def initialize(car_info)
    @make = car_info[:make]
    @model = car_info[:model]
    @year = car_info[:year]
    @mpg = car_info[:mpg]
    @fuel_type = car_info[:fuelType]
  end
end
