require 'rails_helper'

RSpec.describe FootprintService do
  describe 'Get user\'s footprint' do
    let(:url) { ENV['HOST_URL']}
    before do
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_footprints.json')
      )
    end

    it 'returns parsed JSON data for a user\'s monthly footprint' do
      current_user = create(:user)
      year = 2020

      response = FootprintService.get_footprints(year, current_user)

      expect(response).to be_a(Array)
      first = response[0]

      expect(first[:month]).to be_a(String)
      expect(first[:month]).to eq('January')
      expect(response.last[:month]).to eq('December')
      expect(first[:carbonInKg]).to be_a(Float)
    end
  end
  describe 'Create new footprint' do
    let(:url) { ENV['HOST_URL']}
    
    before do
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/new_footprint.json')
      )
    end

    it 'returns parsed JSON data for a new footprint input' do
      current_user = create(:user)
      car_info = {make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:2010}
      car = Car.new(car_info)

      footprint_info = {car_id: car, total_mileage: 204, date: {month: '2', year: '2020'}}
      response = FootprintService.new_footprint(footprint_info, current_user)

      expect(response).to be_a(Hash)
      expect(response[:data]).to be_a(Hash)
      expect(response[:data][:createFootprintAndCarMonthlyMileage]).to be_a(Hash)
      expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint]).to be_a(Hash)
      expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint][:id]).to be_a(String)
      expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint][:id]).to eq('1')
    end
  end

  describe 'Get User Footprint Years' do 
    let(:url) { ENV['HOST_URL']}
    
    before do
      stub_request(:post, url).to_return(
        status: 200,
        body: File.read('spec/fixtures/get_footprint_years.json')
      )
    end

    it 'returns an array of years as integers' do 
      current_user = create(:user)

      response = FootprintService.get_user_footprint_years(current_user)

      expect(response).to be_a(Array)

      response.each do |r|
        expect(r).to be_a(Integer)
      end
    end

  end
end
