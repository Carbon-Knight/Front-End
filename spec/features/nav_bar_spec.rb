require 'rails_helper'

describe 'Nav Bar' do
  describe 'As a Visitor' do
    it 'I only see the login button on the nav bar' do
      visit root_path

      within('.nav') do
        expect(page).to have_link('Log In', href: '/auth/google_oauth2')
        expect(page).to_not have_link('Friends')
        expect(page).to_not have_link('Carbon Calculator')
      end
    end
    describe 'As a User' do
      before :each do
        @user = User.create(name: 'Mr. Fake', email: 'fake@email.com', uid: '7', token: 'token')

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit dashboard_path
      end
      it 'I see all nav bar links but log in' do
        within('.nav') do
          expect(page).to_not have_link('Log In')
          expect(page).to have_link('Home', href: '/dashboard')
          expect(page).to have_link('Friends', href: '/friends')
          expect(page).to have_link('Carbon Calculator', href: '/carbon_calc')
          expect(page).to have_link('Offsets', href: '/offsets')
          expect(page).to have_link('Resources', href: '/resources')
          expect(page).to have_link('Log Out', href: '/log_out')
        end
      end
      xit 'I am taken to the correct landing page' do
        click_link('Friends')
        expect(current_path).to eq('/friends')

        click_link('Carbon Calculator')
        expect(current_path).to eq('/carbon_calc')

        click_link('Offsets')
        expect(current_path).to eq('/offsets')

        click_link('Resources')
        expect(current_path).to eq('/resources')

        click_link('Home')
        expect(current_path).to eq('/dashboard')

        click_link('Log Out')
        expect(current_path).to eq(root_path)

        expect(page).to have_link('Log In', href: '/auth/google_oauth2')
      end
    end
  end
end
