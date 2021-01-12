require 'rails_helper'

describe 'As a user that is logged in' do
  describe 'I can log out' do
    it 'I click logout and I am redirected to the welcome page' do
      stub_omniauth
      visit root_path
      click_link 'Log in with Google'
      click_link 'Log Out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to_not have_link('Log Out')
    end
  end
end
