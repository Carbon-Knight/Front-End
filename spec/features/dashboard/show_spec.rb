require 'rails_helper'

describe 'As a User' do
  describe 'When visiting the dashboard page' do
    before :each do
      user_data = stub_omniauth
      user = User.find_or_create_by(uid: user_data[:uid])
      user.name = user_data[:info][:name]
      user.email = user_data[:info][:email]
      user.token = user_data[:credentials][:token]
      user.image = user_data[:info][:image]
      user.save

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
    end

    it 'Has a users google information on the page' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.image)
    end

    it "has links from the nav application layout" do
      within first '.nav' do
        expect(page).to have_link('Home')
        expect(page).to have_link('Friends')
        expect(page).to have_link('Carbon Calculator')
        expect(page).to have_link('Offsets')
        expect(page).to have_link('Resources')
        expect(page).to have_link('Log Out')
      end
    end

    it 'has links for the leader board and carbon calculator' do
      within '.user-carbon-data' do
        expect(page).to have_link('Visit Leader Board Here')
        expect(page).to have_link('Input Data Here')
      end
    end
  end
end
