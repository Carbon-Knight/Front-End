class DashboardController < ApplicationController
  before_action :require_user
  def show
    year = select_year
    # To display the years available for a user to select based on their record:
    @footprint_years = Rails.cache.fetch("#{current_user.id}/#{year}/#{Time.now.year}") do
       FootprintFacade.get_user_footprint_years(current_user)
    end

    @footprints = Rails.cache.fetch("footprints/#{current_user.id}/#{year}") do
      FootprintFacade.return_data(year, current_user)
    end
  end
  def select_year
    return params[:footprint_year] if params[:year]
    Time.now.year
  end
end
