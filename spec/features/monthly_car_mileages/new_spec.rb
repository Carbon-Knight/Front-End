require 'rails_helper'

describe 'Carbon Footprint Calculation for Car Monthly Mileages Page' do
  describe 'As a visitor' do
    it 'I am unable to visit the dashboard' do
      visit dashboard_path
      expect(current_path).to eq('/')
      expect(page).to have_content('Please log in')
    end
  end

  describe 'As an authenticated user' do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click link on dashboard and I am taken to the form' do
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
end
