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
    years = FootprintService.get_user_footprint_years(current_user)
    years << Time.now.year unless years.include?(Time.now.year)
    years
  end

  def self.get_total_carbon_for_year(footprints)
    Footprint.total_carbon_for_year(footprints)
  end
end
