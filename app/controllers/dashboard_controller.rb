class DashboardController < ApplicationController
  before_action :require_user
  def show
    @footprints = FootprintFacade.get_footprints(params[:year], current_user)
    # require "pry"; binding.pry
  end
end
