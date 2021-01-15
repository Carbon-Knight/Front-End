require 'rails_helper'

describe 'Carbon Footprint Calculation for Car Monthly Mileages Page' do
  before :each do 
    url = ENV['HOST_URL']
    stub_request(:post, url).to_return(
      status: 200,
      body: File.read('spec/fixtures/get_footprints.json')
    )
  end
  describe 'As a visitor' do
    it 'I am unable to visit the dashboard' do
      visit dashboard_path
      expect(current_path).to eq('/')
      expect(page).to have_content('Please log in')
    end
  end

  describe 'As an authenticated user with no cars in the DB' do
    before :each do
      @user = create(:user)
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      allow(FootprintFacade).to receive(:get_user_footprint_years).with(@user).and_return([2018, 2019, 2020, 2021])
    end

    it 'I can click link on dashboard and I am taken to the form' do
      visit dashboard_path
      within('.nav') do
        click_link 'Carbon Calculator'
      end
      expect(current_path).to eq(carbon_calculator_path)
    end

    it 'I see a link to add a new car' do
      visit carbon_calculator_path

      expect(page).to have_link('Add a Car')
    end
  end

  describe 'As an authenicated user with cars in the DB' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      car_1 = { make: 'Ford', mpg: 24, fuelType: 'gasoline', model: 'Mustang', year: 2013 }
      car_2 = { make: 'Honda', mpg: 31, fuelType: 'gasoline', model: 'Civic', year: 2018 }
      car_3 = { make: 'Dodge', mpg: 15, fuelType: 'diesel', model: 'Ram', year: 2010 }
      @cars = [Car.new(car_1), Car.new(car_2), Car.new(car_3)]
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(@cars)

      visit carbon_calculator_path
    end

    it 'I dont see a message saying I have not added any cars yet' do
      expect(page).to_not have_css('#no-cars-alert')
    end
  end
end
