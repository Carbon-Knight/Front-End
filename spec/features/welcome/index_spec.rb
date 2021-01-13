require 'rails_helper'

describe 'Welcome Page' do
  describe 'Index' do
    before :each do
      stub_omniauth
      visit root_path
    end

    it 'Welcomes visitor w/ a login' do
      expect(page).to have_content('Welcome to CarbonKnight')
      expect(page).to have_content('An app to track your carbon footprint over time')
      expect(page).to have_link('Log in with Google')
    end

    it 'Logs in/ registers with google OAuth' do
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
