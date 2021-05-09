class CarMonthlyMileage
  attr_reader :id,
              :month,
              :year,
              :total_mileage,
              :car

  def initialize(data)
    @id = data[:id].to_i
    @month = data[:month]
    @year = data[:year]
    @total_mileage = data[:totalMileage]
    @car = Car.new(data[:car])
  end
end
