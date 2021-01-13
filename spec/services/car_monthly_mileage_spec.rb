require 'rails_helper'

RSpec.describe FootprintService do
  describe 'Get user\'s footprint' do
    let(:url) { ENV['HOST_URL']}
    before do
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_car_monthly_mileages.json')
      )
    end

    it 'returns parsed JSON data for a user\'s car monthly mileages' do
      current_user = create(:user)

      response = CarMonthlyMileageService.get_car_monthly_mileages(current_user)
      first_data = response[:data][:fetchAllUserCarMonthlyMileages][0]
      expect(response).to be_a(Hash)
      expect(response).to have_key(:data)
      expect(response[:data]).to have_key(:fetchAllUserCarMonthlyMileages)
      expect(response[:data][:fetchAllUserCarMonthlyMileages]).to be_an(Array)
      expect(first_data).to be_a(Hash)
      expect(first_data).to have_key(:id)
      expect(first_data).to have_key(:month)
      expect(first_data).to have_key(:year)
      expect(first_data).to have_key(:totalMileage)
    end
  end
end
