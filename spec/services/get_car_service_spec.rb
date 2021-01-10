require 'rails_helper'

describe CarService do
  let(:url) { ENV['HOST_URL'] }

  before do
    stub_request(:post, url).to_return(
      status: 200,
      body: File.read('spec/fixtures/get_cars.json')
    )
  end

  it 'returns parsed JSON data for a user\'s new car' do
    current_user = create(:user)

    response = CarService.get_cars(current_user)
    expect(response).to be_a(Array)
    first = response[0]

    expect(first[:userId]).to be_a(Integer)
    expect(first[:make]).to be_a(String)
    expect(first[:model]).to be_a(String)
    expect(first[:year]).to be_a(Integer)
    expect(first[:mpg]).to be_a(Integer)
    expect(first[:fuelType]).to be_a(String)
  end

  it "returnes parsed json data for a user with multiple cars" do
    current_user = create(:user)

    response = CarService.get_cars(current_user)
    expect(response).to be_a(Array)
    first = response[0]
    second = response[1]

    expect(first[:userId]).to be_a(Integer)
    expect(first[:make]).to be_a(String)
    expect(first[:model]).to be_a(String)
    expect(first[:year]).to be_a(Integer)
    expect(first[:mpg]).to be_a(Integer)
    expect(first[:fuelType]).to be_a(String)


    expect(second[:userId]).to be_a(Integer)
    expect(second[:make]).to be_a(String)
    expect(second[:model]).to be_a(String)
    expect(second[:year]).to be_a(Integer)
    expect(second[:mpg]).to be_a(Integer)
    expect(second[:fuelType]).to be_a(String)
  end
end
