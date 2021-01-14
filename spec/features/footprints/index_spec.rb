require 'rails_helper'

describe 'Footprint Index Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      file = File.read('spec/fixtures/get_car_monthly_mileages.json')
      car_monthly_mileages = JSON.parse(file, symbolize_names: true)[:data][:fetchAllUserCarMonthlyMileages]

      footprints = [{ month: 'January', carbonInKg: 45.21 },
                    { month: 'February', carbonInKg: 50.41 },
                    { month: 'March', carbonInKg: nil },
                    { month: 'April', carbonInKg: nil },
                    { month: 'May', carbonInKg: nil },
                    { month: 'June', carbonInKg: nil },
                    { month: 'July', carbonInKg: nil },
                    { month: 'August', carbonInKg: nil },
                    { month: 'September', carbonInKg: nil },
                    { month: 'October', carbonInKg: nil },
                    { month: 'November', carbonInKg: nil },
                    { month: 'December', carbonInKg: nil }]

      allow(CarMonthlyMileageService).to receive(:get_car_monthly_mileages).with(@user).and_return(car_monthly_mileages)
      allow(FootprintService).to receive(:get_footprints).with(2021, @user).and_return(footprints)
      allow(FootprintService).to receive(:get_user_footprint_years).with(@user).and_return([2020])
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

    it 'I see details of each footprint' do
      visit '/footprints'
      within '.footprint-details' do
        expect(page).to have_css('.footprint-1')
      end
      within '.footprint-1' do
        expect(page).to have_css('.month')
        expect(page).to have_css('.car-monthly-mileage-June')
        expect(page).to have_css('.total-mileage')
        expect(page).to have_css('.year')
      end
    end

    it 'Each footprint has a button to edit it' do
      visit '/footprints'
      within '.footprint-1' do
        expect(page).to have_link('Edit Footprint')
      end
    end
  end

  describe 'As an authenticated user with no footprints' do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can click link on dashboard and I am taken to the form' do
      footprints = []
      allow(CarMonthlyMileageFacade).to receive(:get_car_monthly_mileages).with(@user).and_return(footprints)
      visit '/footprints'
      expect(page).to_not have_css('footprint-details')
      expect(page).to have_content('Oh snap! You don\'t have any carbon footprints yet.')
    end
  end
end
