require 'rails_helper'

describe 'Add a Car Form Page' do
  describe "As a visitor" do
    it "I am unable to visit the dashboard" do
      visit dashboard_path
      expect(current_path).to eq('/')
      expect(page).to have_content("Please log in")
    end
  end
  
  describe 'As an authenticated user' do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can add a new car by filling out a form" do
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)

      visit carbon_calculator_path

      expect(page).to_not have_css('.calculate-footprint')

      click_link "Add a Car"
      expect(current_path).to eq("/cars/new")

      fill_in :make, with: "Ford"
      fill_in :model, with: "Mustang"
      fill_in :year, with: 2013
      fill_in :mpg, with: 24

      select "gasoline", :from => "fuel_type"

      car_info = {make:"Ford",mpg:24,fuelType:"gasoline",model:"Mustang",year:2013}
      cars = [Car.new(car_info)]
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)

      new_car = {
        :make=>"Ford",
        :model=>"Mustang",
        :year=>"2013",
        :fuel_efficiency=>"24",
        :fuel_type=>"Gasoline"
      }
      allow_any_instance_of(CarsController).to receive(:new_car_params).and_return(new_car)
      allow(CarService).to receive(:new_car).with(new_car, @user).and_return(nil)

      click_button "Add Vehicle"

      expect(current_path).to eq(carbon_calculator_path)

      expect(page).to have_css('.calculate-footprint')
      expect(page).to have_select(:car, :options => ['2013 Ford Mustang'])

    end

    it "I cannot add a new car with missing fields" do
      visit new_car_path

      fill_in :model, with: 'Mustang'
      fill_in :year, with: 2013
      fill_in :mpg, with: 24

      select "gasoline", :from => 'fuel_type'

      click_button "Add Vehicle"

      expect(page).to have_content('Missing fields')
      expect(page).to have_css('.new_car_form')
    end
  end
end
