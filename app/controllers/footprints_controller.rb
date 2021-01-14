class FootprintsController < ApplicationController
  def index
    @car_monthly_mileages = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
  end

  def new
    @cars = CarsFacade.get_cars(current_user)
  end

  def create
    # TODO: add error messages and render :new
    FootprintFacade.new_footprint(new_footprint_params, current_user)
    Rails.cache.delete("footprint_years/#{current_user.id}/#{Time.now.year}")
    Rails.cache.delete("footprints/#{current_user.id}/#{params[:date][:year]}")
    
    redirect_to '/dashboard'
  end

  def edit
    footprint_id = params[:id].to_i
    @footprint = find_car_monthly_mileage(footprint_id, current_user)
  end

  def update
    car_monthly_mileage = find_car_monthly_mileage(params[:id].to_i, current_user)

    if params[:total_mileage] == ''
      flash[:error] = 'You need to fill in the new total mileage'
      redirect_to edit_footprint_path
    else
      CarMonthlyMileageFacade.update_car_monthly_mileage(car_monthly_mileage, new_footprint_params)
      redirect_to footprints_path
    end
  end

  private

  def new_footprint_params
    params.permit(:car_id, :total_mileage, :date => [:month, :year])
  end

  def find_car_monthly_mileage(id, current_user)
    car_monthly_mileages = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
    car_monthly_mileages.find do |car_monthly_mileage|
      car_monthly_mileage.id == id
    end
  end
end
