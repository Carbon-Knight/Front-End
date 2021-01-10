require 'rails_helper'

describe 'As a User' do
  describe 'When visiting the dashboard page' do
    before :each do
      @user = User.create(name: 'Mr. Fake', email: 'fake@email.com', uid: '7', token: 'token')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path
    end

    it 'I see my name' do
      expect(page).to have_content('Mr. Fake')
    end

    it 'I see my previous footprint data and a button to input new data' do
      expect(page).to have_content('Your Carbon Footprint Estimate:')
      expect(page).to have_css('.footprint-graph')
      within('.footprint-graph') do
        # TODO:
        # expect(page).to have month data etc etc
        # mock a new footprint
        # expect(page).to_not have_content('You have no footprint data')
      end
    end
    it 'I see no previous data when I have not entered any data' do
      expect(page).to have_content('Your Carbon Footprint Estimate:')
      expect(page).to have_css('.footprint-graph')
      within('.footprint-graph') do
        expect(page).to have_content('You have no footprint data')
        expect(page).to have_button('Input New Data')
      end
    end
  end
end
