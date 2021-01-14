class FootprintFacade
  def self.new_footprint(footprint_params, current_user)
    FootprintService.new_footprint(footprint_params, current_user)
  end

  def self.get_footprints(year, current_user)
    footprints = FootprintService.get_footprints(year, current_user)
    footprints.map do |footprint|
      new_footprint = Footprint.new(footprint, year)
      [new_footprint.month, new_footprint.carbon_in_kg]
    end
  end

  def self.get_user_footprint_years(current_user)
    FootprintService.get_user_footprint_years(current_user)
  end

  def self.get_total_carbon_for_year(year, current_user)
    footprints = get_footprints(year, current_user)
    footprints.sum do |_, carbon_in_kg|
      carbon_in_kg
    end
  end
end
