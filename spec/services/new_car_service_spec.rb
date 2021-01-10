require 'rails_helper' 

describe CarService do 
  let(:url) { 'http://localhost:3000/graphql' }
  # let(:client) { Graphlient::Client.new(ENV['HOST_URL'], schema_path: 'spec/support/fixtures/graphql_schema.json') }
  let(:query) do 
    <<~GRAPHQL
      mutation {
        createUserCar(input: {
          userId: 1, make: "Toyota", model: "Four Runner", year: "2000", mpg: 20, fuelType: "gasoline"
        }) {
          car {
            userId
          }
        }
      }
    GRAPHQL
  end

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

  # before do 
  #   stub_request(:post, url).to_return(
  #     status: 200, 
  #     body: json_response
  #   )
  # end

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

    require 'pry'; binding.pry

  end
end
