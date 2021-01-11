class Footprint
  attr_reader :car_id,
              :total_mileage,
              :month,
              :year

  def initialize(footprint_info)
    @car_id = footprint_info[:car_id]
    @total_mileage = footprint_info[:total_mileage]
    @month = footprint_info[:month]
    @year = footprint_info[:year]
  end
end
