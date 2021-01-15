class Footprint
  attr_reader :month,
              :year,
              :carbon_in_kg

  def initialize(footprint_info, year)
    @month = footprint_info[:month]
    @year = year
    @carbon_in_kg = footprint_info[:carbonInKg] ? footprint_info[:carbonInKg] : 0
  end

  def self.total_carbon_for_year(footprints)
    footprints.sum do |footprint|
      footprint[1]
    end.round(2)
  end
end
