class DashboardController < ApplicationController
  before_action :require_user
  def show
    @year = select_year
    # To display the years available for a user to select based on their record:
    # TODO be implemented
    # @footprint_years = FootprintFacade.get_user_footprint_years(current_user)
    @footprints = Rails.cache.fetch("footprints/#{current_user.id}/#{@year}") do
      FootprintFacade.get_footprints(@year, current_user)
    end
    @total_carbon_for_year = FootprintFacade.get_total_carbon_for_year(@year, current_user)
  end

  def select_year
    return params[:footprint_year] if params[:footprint_year]
    Time.now.year
  end
end
