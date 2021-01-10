require 'rails_helper' 

describe CarService do 
  let(:url) { ENV['HOST_URL'] }
  let(:json_response) do 
    {
      "data": {
        "createUserCar": {
          "car": {
            "userId": 1
          }
        }
      }
    }.to_json
  end

  before do 
    stub_request(:post, url).to_return(
      status: 200, 
      body: json_response
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
