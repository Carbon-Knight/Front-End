class Footprint
  # TODO REmove: I changed the attributes to match up what is needed for our graph 
  attr_reader :month, 
              :year, 
              :carbon_in_kg

  def initialize(footprint_info, year)
    @month = footprint_info[:month]
    @year = year
    @carbon_in_kg = footprint_info[:carbon_in_kg]
  end
end
