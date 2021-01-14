class Footprint
  attr_reader :month,
              :year,
              :carbon_in_kg

  def initialize(footprint_info, year)
    @month = footprint_info[:month]
    @year = year
    @carbon_in_kg = footprint_info[:carbonInKg] ? footprint_info[:carbonInKg] : 0
  end
end
