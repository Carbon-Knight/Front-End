require 'rails_helper'

describe 'Footprint Index Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      # allow(FootprintFacade).to receive()
      # car_info = [{ make: 'Ford', mpg: 24, fuelType: 'gasoline', model: 'Mustang', year: 2013 }]
      # allow(CarService).to receive(:get_footprints).with(@user).and_return(@footprints)
      # CarsFacade.get_cars(@user)
      # car = Car.create(
      #   user_id: 1,
      #   make: 'Fiat',
      #   model: '500',
      #   year: 2015,
      #   mpg: 14,
      #   fuel_type: 'gasoline'
      # )
      # footprint = Footprint.create(
      #   carbon_in_kg: 14.4,
      #   offset_cost_total: 0.82,
      #   offset_cost_currency: 'USD'
      # )
      # CarMonthlyMileage.create(
      #   car_id: car.id,
      #   footprint_id: footprint.id,
      #   total_mileage: 1090,
      #   month: 'July',
      #   year: '2020'
      # )
      # stub_request(:post, url).to_return(
      #   status: 200,
      #   body: File.read('spec/fixtures/get_cars.json')
      # )
    end

    it 'I can click the link to view previous footprints' do
      visit '/dashboard'
      click_link('View Previous Footprints')
      expect(current_path).to eq('/footprints')
      within '.footprint-header' do
        expect(page).to have_content('Your Previous Carbon Footprints')
      end
    end
  end
end


# { query :
#   query {
#       fetchAllUserCarMonthlyMileages(user_id: Int) {
#           id
#           month
#           year
#           totalMileage
#       }
#   }
# }         

# {
#   "data": {
#      "fetchAllUserCarMonthlyMileages": [
#       {
#         id: 1,
#         month: June,
#         year: 2020,
#         totalMileage: 12345
#       }
#       {
#         id: 2,
#         month: July,
#         year: 2021,
#         totalMileage: 6789
#       }
#     ]
#   }
# }