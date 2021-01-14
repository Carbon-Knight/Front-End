require 'rails_helper'

describe 'Welcome Page' do
  describe 'Index' do
    before :each do
      stub_omniauth

      url = ENV['HOST_URL']
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_footprints.json')
      )
      @user = create(:user)
      allow(FootprintFacade).to receive(:get_user_footprint_years).with(@user).and_return([2018, 2019, 2020, 2021])
      visit root_path
    end

    it 'Welcomes visitor w/ a login' do
      expect(page).to have_content('Welcome to CarbonKnight')
      expect(page).to have_content('An app to track your carbon footprint over time')
      expect(page).to have_link('Log in with Google')
    end

    it 'Logs in/ registers with google OAuth' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      click_link 'Log in with Google'
      expect(current_path).to eq(dashboard_path)
    end

    it 'A visit can see the resources link in nav bar' do
      within '.nav' do
        expect(page).to have_link('Resources')
        click_link 'Resources'
        expect(current_path).to eq('/resources')
      end
    end
  end
end
