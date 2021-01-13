require 'rails_helper'

describe 'Footprint edit Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      file = File.read('spec/fixtures/get_car_monthly_mileages.json')
      car_monthly_mileages = JSON.parse(file, symbolize_names: true)[:data][:fetchAllUserCarMonthlyMileages]

      allow(CarMonthlyMileageService).to receive(:get_car_monthly_mileages).with(@user).and_return(car_monthly_mileages)
      @result = CarMonthlyMileageFacade.get_car_monthly_mileages(@user)
      @first_footprint = @result.first
      # {"id":1,"month":"June","year":2020,"totalMileage":12345}
    end

    it 'Clicking edit link will redirect me to an edit page' do
      visit '/footprints'
      within ".footprint-#{@first_footprint.id}" do
        click_link 'Edit Footprint'
        expect(current_path).to eq("/footprints/#{@first_footprint.id}/edit")
      end
      expect(page).to have_css('#edit-footprint-header')
    end
  end
end

# As a user
# On the update a footprint/car monthly mileage page
# When I fill in a new total mileage
# And click the "Update" button
# I am taken back to my dashboard
# And I see a graph with that footprint's updated information


# As a user
# When I click an update link from my footprints index page
# I am taken to an update form
# Where I see that footprint/car monthly mileages data prepopulated
# And I can fill in a new total mileage