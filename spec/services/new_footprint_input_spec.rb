require 'rails_helper'

describe FootprintService do
  let(:url) { ENV['HOST_URL'] }

  before do
    stub_request(:post, url).to_return(
      status: 200,
      body: File.read('spec/fixtures/new_footprint.json')
    )
  end

  it 'returns parsed JSON data for a user\'s new car' do
    current_user = create(:user)

    car_params = {
      :make=>"Toyota",
      :model=>"Mustang",
      :year=>"2013",
      :fuel_efficiency=>"24",
      :fuel_type=>"Gasoline"
    }

    response = CarService.new_car(car_params, current_user)
    expect(response).to be_a(Hash)

    expect(response[:data]).to be_a(Hash)
    expect(response[:data][:createUserCar]).to be_a(Hash)
    expect(response[:data][:createUserCar][:car]).to be_a(Hash)
    expect(response[:data][:createUserCar][:car][:userId]).to be_a(Integer)
    expect(response[:data][:createUserCar][:car][:userId]).to eq(1)
  end
end
