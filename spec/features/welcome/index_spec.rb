require 'rails_helper'

describe 'Welcome Page' do
  describe 'Index' do
    before :each do
      stub_omniauth
    end

    it 'Welcomes visitor w/ a login' do
      visit root_path

      expect(page).to have_content('Welcome to CarbonKnight')
      expect(page).to have_content('CarbonKight is a way for you to track your carbon footprint over time')
      expect(page).to have_link('Login with Google')
    end

    it 'Logs in/ registers with google OAuth' do
      visit root_path
      click_link 'Login with Google'
      expect(current_path).to eq(dashboard_path)
    end
  end
end
