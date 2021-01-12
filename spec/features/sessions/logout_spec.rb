require 'rails_helper'

describe 'As a user that is logged in' do
  describe 'I can log out' do
    it 'I click logout and I am redirected to the welcome page' do
      url = ENV['HOST_URL']
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_footprints.json')
      )
      
      stub_omniauth
      visit root_path
      click_link 'Login with Google'
      click_link 'Log Out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to_not have_link('Log Out')
    end
  end
end
