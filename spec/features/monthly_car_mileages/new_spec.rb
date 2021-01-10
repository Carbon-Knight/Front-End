require 'rails_helper'

describe 'Carbon Footprint Calculation for Car Monthly Mileages Page' do
  describe 'As an authenticated user' do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "I see a link to add a new car" do
      cars = []
      allow(CarsFacade).to receive(:get_cars).with(@user).and_return(cars)
      visit '/car_monthly_mileages/new'

      expect(page).to have_link("Add a Car")
    end
  end
end
