require 'rails_helper'

describe 'Carbon Footprint Calculation for Car Monthly Mileages Page' do
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
      expect(current_path).to eq('/car_monthly_mileages/new')
    end

    it 'I see a link to add a new car' do
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)
      visit '/car_monthly_mileages/new'

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

      visit '/car_monthly_mileages/new'
      # allow(CarService).to receive(:get_cars).with(@user).and_return(nil)
      # allow_any_instance_of(CarsController).to receive(:new_car_params).and_return(new_car)
      # allow(CarService).to receive(:new_car).with(new_car, @user).and_return(nil)
    end

    it 'I dont see a message saying I have not added any cars yet' do
      expect(page).to_not have_css('#no-cars-alert')
    end

    it 'I see the form to add a new footprint' do
      within '.create-monthly-mileage' do
        expect(page).to have_css('.select-car')
        expect(page).to have_css('.select-month')
        expect(page).to have_css('.select-year')
        expect(page).to have_button('Create Footprint for Month')
      end
    end

    it 'I see all my cars in the drop down selector'

    it 'I can fill out form and submit it'
  end
end
