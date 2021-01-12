require 'rails_helper'

describe 'As a user that is logged in' do
  describe 'I can log out' do
    it 'I click logout and I am redirected to the welcome page' do
      @user = create(:user, name: 'Mr. Fake')
      user_data = stub_omniauth
      @user = User.find_or_create_by(uid: user_data[:uid])
      @user.name = user_data[:info][:name]
      @user.email = user_data[:info][:email]
      @user.token = user_data[:credentials][:token]
      @user.image = user_data[:info][:image]
      @user.save
      
      file = File.read('spec/fixtures/get_footprints.json')
      footprints = JSON.parse(file, symbolize_names: true)[:data][:fetchUserFootprints][:footprints]
      year = Time.now.year
      allow(FootprintService).to receive(:get_footprints).with(year, @user).and_return(footprints)

      visit root_path
      click_link 'Login with Google'
      click_link 'Log Out'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged out!')
      expect(page).to_not have_link('Log Out')
    end
  end
end
