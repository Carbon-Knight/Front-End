require 'rails_helper'

describe 'Welcome Page' do
  describe 'Index' do
    before :each do
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
