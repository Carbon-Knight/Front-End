class FootprintFacade
  def self.new_footprint(footprint_params, current_user)
    FootprintService.new_footprint(footprint_params, current_user)
  end

  def self.get_footprints(year, current_user)
    footprints = FootprintService.get_footprints(year, current_user)
    result = footprints.map do |footprint|
      new_footprint = Footprint.new(footprint, year)
      [new_footprint.month, new_footprint.carbon_in_kg]
    end
    require "pry"; binding.pry
  end
end
