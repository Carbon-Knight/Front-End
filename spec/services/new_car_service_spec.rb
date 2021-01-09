require 'rails_helper' 

describe CarService do 
  let(:url) { 'http://localhost:3000/graphql' }
  let(:client) { Graphlient::Client.new(ENV['HOST_URL'], schema_path: 'spec/support/fixtures/graphql_schema.json') }
  let(:query) do 
    <<~GRAPHQL
      mutation do 
        createUserCar(input: {
          userId: 1, make: "Toyota", model: "Four Runner", year: "2000", mpg: 20, fuelType: "gasoline"
        }) do 
          car {
            user_id
          }
        end
      end
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

  before do 
    stub_request(:post, url).to_return(
      status: 200, 
      body: json_response
    )
  end

  it 'returns parsed JSON data for a user\'s new car' do 
    user = create(:user)

    new_car = {
      :make=>"Ford", 
      :model=>"Mustang", 
      :year=>"2013", 
      :mpg=>"24", 
      :fuel_type=>"Gasoline"
    }

    response = client.query(query)
    require 'pry'; binding.pry
    # ["data"]["createUserCar"]["car"]
    expect(result).to be_a(Hash)

    expect(result).to have_key("make")
    expect(result["make"]).to be_a(String)

    expect(result).to have_key("model")
    expect(result["model"]).to be_a(String)

    expect(result).to have_key("year")
    expect(result["year"]).to be_a(Integer)

    expect(result).to have_key("mpg")
    expect(result["mpg"]).to be_a(Integer)
  end
end
