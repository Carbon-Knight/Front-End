require 'rails_helper'

describe FootprintService do
  let(:url) { ENV['HOST_URL'] }

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

    footprint_info = {car_id: car, total_mileage: 204, month: 'February', year: '2020'}
    response = FootprintService.new_footprint(footprint_info, current_user)
    expect(response).to be_a(Hash)
    expect(response[:data]).to be_a(Hash)
    expect(response[:data][:createFootprintAndCarMonthlyMileage]).to be_a(Hash)
    expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint]).to be_a(Hash)
    expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint][:id]).to be_a(String)
    expect(response[:data][:createFootprintAndCarMonthlyMileage][:footprint][:id]).to eq('1')
  end
end
