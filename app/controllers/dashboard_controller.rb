class DashboardController < ApplicationController
  before_action :require_user
  def show
    year = select_year
    # To display the years available for a user to select based on their record: 
    Rails.cache.fetch("#{current_user.id}/#{year}/#{Time.now.year}") do 
      @footprint_years = FootprintFacade.get_user_footprint_years(current_user) 
    end 
    
    Rails.cache.fetch("footprints/#{current_user.id}/#{year}") do 
      @footprints = FootprintFacade.get_footprints(year, current_user)
    end 
    
  end
  
  private 

  def select_year 
    return params[:year] if params[:year]
    Time.now.year
  end
  
end
