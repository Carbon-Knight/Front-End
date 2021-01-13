class DashboardController < ApplicationController
  before_action :require_user
  def show
    year = select_year
    # To display the years available for a user to select based on their record:
    Rails.cache.fetch("#{current_user.id}/#{year}/#{Time.now.year}") do
      @footprint_years = FootprintFacade.get_user_footprint_years(current_user)
    end

    Rails.cache.fetch("footprints/#{current_user.id}/#{year}") do
      footprint_data = FootprintFacade.return_data(year, current_user)
      no_footprints = footprint_data.values.all? do |value|
          value == 0
      end
      if no_footprints == true
        @footprints = {}
      else
        @footprints = footprint_data
      end
    end
  end
  def select_year
    return params[:footprint_year] if params[:year]
    Time.now.year
  end
end
