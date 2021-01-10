require 'rails_helper'

describe 'As a User' do
  describe 'When visiting the dashboard page' do
    before :each do
      @user = create(:user, name: 'Mr. Fake')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path
    end
    it 'Has a users name on the page' do
      expect(page).to have_content('Mr. Fake')
    end
  end
end
