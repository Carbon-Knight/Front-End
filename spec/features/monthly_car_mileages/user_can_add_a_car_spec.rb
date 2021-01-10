require 'rails_helper'

describe 'Add a Car Form Page' do
  describe 'As an authenticated user' do
    before :each do
      @user = User.create(name: 'Mr. Fake', email: 'fake@email.com', uid: '7', token: 'token')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I can add a new car by filling out a form" do
      visit "/car_monthly_mileages/new"

      expect(page).to_not have_css('.create-monthly-mileage')
      
      click_link "Add a Car"
      expect(current_path).to eq("/cars/new")
      
      fill_in :make, with: "Ford"
      fill_in :model, with: "Mustang"
      fill_in :year, with: 2013
      fill_in :fuel_efficiency, with: 24
      
      select "Gasoline", :from => "fuel_type"
      
      click_button "Add Vehicle"
      
      expect(current_path).to eq("/car_monthly_mileages/new")
      
      expect(page).to have_css('.create-monthly-mileage')
      expect(page).to have_select(:cars, :options => ['2013 Ford Mustang'])
      
    end

    xit "I cannot add a new car with missing fields" do 
      visit cars_new_path 

      fill_in :model, with: "Mustang"
      fill_in :year, with: 2013
      fill_in :fuel_efficiency, with: 24

      select "Gasoline", :from => "fuel_type"

      click_button "Add Vehicle"

      expect(current_path).to eq(cars_new_path)
      expect(page).to have_content("Missing fields [ ]  required...")
    end
  end
end
