class CarMonthlyMileage
  attr_reader :id,
              :month,
              :year,
              :total_mileage
  def initialize(data)
    @id = data[:id]
    @month = data[:month]
    @year = data[:year]
    @total_mileage = data[:totalMileage]
  end
end
