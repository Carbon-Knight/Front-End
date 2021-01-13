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

  # def self.get_footprints(year, current_user)
  #   footprints = FootprintService.get_footprints(year, current_user)
  #   footprints.map do |footprint|
  #     Footprint.new(footprint, year)
  #   end
  # end

  def self.return_data(year, current_user)
    footprints = get_footprints(year, current_user)
    footprints.each_with_object({}) do |footprint, hash|
      hash[footprint[0]] = footprint[1]
    end
  end

  # def self.return_data(year, current_user)
  #   footprints = group_by_month(year, current_user)
  #
  #   footprints.each_with_object({}) do |x, y|
  #     # require "pry"; binding.pry
  #   end
  # end
end
