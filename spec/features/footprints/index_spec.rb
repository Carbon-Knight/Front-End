require 'rails_helper'

describe 'Footprint Index Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      file = File.read('spec/fixtures/get_car_monthly_mileages.json')
      car_monthly_mileages = JSON.parse(file, symbolize_names: true)[:data][:fetchAllUserCarMonthlyMileages]

      allow(CarMonthlyMileageService).to receive(:get_car_monthly_mileages).with(@user).and_return(car_monthly_mileages)
      @result = CarMonthlyMileageFacade.get_car_monthly_mileages(@user)
    end

    it 'I can click the link to view previous footprints' do
      visit '/dashboard'
      click_link('View Previous Footprints')
      expect(current_path).to eq('/footprints')
      within '.footprint-header' do
        expect(page).to have_content('Your Previous Carbon Footprints')
      end
    end
  end
end
