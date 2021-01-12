class DashboardController < ApplicationController
  before_action :require_user
  def show
    #Cache rough draft 
    #year = select_year
    # To display the years available for a user to select based on their record: 
    #Rails.cache.fetch("#{Time.now.year}")
      #@years = FootprintFacade.get_footprint_years(current_user) 
    #end 
    #Rails.cache.fetch("#{current_year}/footprints") do 
    # @footprints = FootprintFacade.get_footprints(year, current_user)
    #end 
    
  end
  
  # def select_year 
  #   return params[:year] if params[:year]
  #   Time.now.year
  # end
  
end
