require 'rails_helper'

describe 'As a user that is logged in' do
  describe 'I can log out' do
    it 'I click logout and I am redirected to the welcome page' do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      click_link 'Log Out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to not_have_link('Log Out')
      expect(page).to not_have_link('Home')
    end
  end
end