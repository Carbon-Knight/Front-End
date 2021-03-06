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
      first = response[0]
      expect(first).to be_a(Hash)
      expect(first).to have_key(:id)
      expect(first).to have_key(:month)
      expect(first).to have_key(:year)
      expect(first).to have_key(:totalMileage)
    end
  end

  describe 'Get a single footprint' do
    let(:url) { ENV['HOST_URL']}

    before do
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_single_car_monthly_mileage.json')
      )
    end

    it 'returns a response with details for a single car monthly mileage' do
      response = CarMonthlyMileageService.get_car_monthly_mileage_by_id(1)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:id)
      expect(response).to have_key(:month)
      expect(response).to have_key(:year)
      expect(response).to have_key(:totalMileage)
    end
  end
end
