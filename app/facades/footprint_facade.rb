class FootprintFacade
  def self.new_footprint(footprint_params, current_user)
    FootprintService.new_footprint(footprint_params, current_user)
  end

  def self.get_footprints(year, current_user)
    footprints = FootprintService.get_footprints(year, current_user)
    footprints.map do |footprint|
      Footprint.new(footprint, year)
    end
  end
end
