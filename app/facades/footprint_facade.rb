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
  end
  
  def self.return_data(year, current_user)
    footprints = get_footprints(year, current_user)
    footprints.each_with_object({}) do |footprint, hash|
      hash[footprint[0]] = footprint[1]
    end
  end

  def self.get_user_footprint_years(current_user)
    FootprintService.get_user_footprint_years(current_user)
  end
end
