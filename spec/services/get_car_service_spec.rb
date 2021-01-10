require 'rails_helper'

describe CarService do
  let(:url) { ENV['HOST_URL'] }

  # before do
  #   stub_request(:post, url).to_return(
  #     status: 200,
  #     body: File.read('spec/fixtures/get_cars.json')
  #   )
  # end

  it 'returns parsed JSON data for a user\'s new car' do
    current_user = create(:user)

    response = CarService.get_cars(current_user)
    require "pry"; binding.pry
    expect(response).to be_a(Hash)
    first = response[:data][:fetchUserCars][0]

    expect(response[:data]).to be_a(Hash)
    expect(response[:data][:fetchUserCars]).to be_a(Array)
    expect(first).to be_a(Hash)
    expect(first[:userId]).to be_a(Integer)
    expect(first[:make]).to be_a(String)
    expect(first[:model]).to be_a(String)
    expect(first[:year]).to be_a(Integer)
    expect(first[:mpg]).to be_a(Integer)
    expect(first[:fuelType]).to be_a(String)
  end
end
