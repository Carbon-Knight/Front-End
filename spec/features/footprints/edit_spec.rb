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
    end

    it 'Clicking edit link will redirect me to an edit page' do
      visit '/footprints'
      within ".footprint-#{@first_footprint.id}" do
        click_link 'Edit Footprint'
        expect(current_path).to eq("/footprints/#{@first_footprint.id}/edit")
      end
      expect(page).to have_css('#edit-footprint-header')
    end

    it 'I see a form to edit with proper info' do
      visit "/footprints/#{@first_footprint.id}/edit"
      within '.edit-footprint-form' do
        expect(page).to have_css('.footprint-month')
        expect(page).to have_content(@first_footprint.month)
        expect(page).to have_css('.footprint-year')
        expect(page).to have_content(@first_footprint.year)
        expect(page).to have_css('.footprint-mileage')
        expect(page).to have_content(@first_footprint.total_mileage)

        fill_in :total_mileage, with: 932

        stub_request(:post, url).to_return(
          status: 200,
          body: File.read('spec/fixtures/updated_car_monthly_mileages.json')
        )
        click_button 'Save'
        expect(current_path).to eq('/footprints')

        file = File.read('spec/fixtures/updated_car_monthly_mileages.json')
        new_car_monthly_mileages = JSON.parse(file, symbolize_names: true)
        allow(CarMonthlyMileageService).to receive(:get_car_monthly_mileages).with(@user).and_return(new_car_monthly_mileages)
        result = CarMonthlyMileageFacade.get_car_monthly_mileages(@user)
        first_footprint = result.first

        expect(first_footprint.total_mileage).to eq(932)
      end
    end

    it 'I get an error if I dont fill in the field' do
      visit "/footprints/#{@first_footprint.id}/edit"
      fill_in :total_mileage, with: ''
      click_button 'Save'

      expect(current_path).to eq("/footprints/#{@first_footprint.id}/edit")
      expect(page).to have_content('You need to fill in the new total mileage')
    end
  end
end
