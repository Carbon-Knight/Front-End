require 'rails_helper'

describe 'New Footprint Estimate Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_cars.json')
      )
    end

    it 'I see a link to add a new footprint estimate and am taken to the form' do
      visit '/dashboard'
      expect(page).to have_link('Input Vehicle Data Here')

      click_link('Input Vehicle Data Here')
      expect(current_path).to eq('/carbon_calculator')
    end

    it 'I can input a new footprint estimate from the form' do
      car_info = [{ make: 'Ford', mpg: 24, fuelType: 'gasoline', model: 'Mustang', year: 2013 }]
      allow(CarService).to receive(:get_cars).with(@user).and_return(car_info)
      CarsFacade.get_cars(@user)

      visit '/carbon_calculator'
      expect(page).to have_select(:car)
      expect(page).to have_field(:total_mileage)
      expect(page).to have_select('input_month_2i')
      expect(page).to have_select('input_year_1i')

      select '2013 Ford Mustang', from: :car
      fill_in :total_mileage, with: 203

      within '.date-time-select' do
        select 'February', from: 'input_month_2i'
        select '2020', from: 'input_year_1i'
      end

      click_button 'Submit'

      expect(current_path).to eq('/dashboard')
    end
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click link on dashboard and I am taken to the form' do
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)
      visit dashboard_path
      click_link 'Input Vehicle Data Here'
      expect(current_path).to eq(carbon_calculator_path)
    end

    it 'I see a link to add a new car' do
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)
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
