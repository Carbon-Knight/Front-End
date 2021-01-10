class CarService
  def self.new_car(car_params, current_user)
    query = "mutation {
       createUserCar(input: {
         userId: #{current_user.id},
         make: \"#{car_params[:make]}\",
         model: \"#{car_params[:year]}\",
         mpg: #{car_params[:mpg].to_i},
         fuelType: \"#{car_params[:fuel_type]}\"
         }) {
           car {
             userId
           }
         }
       }"

    make_request(query)
  end

  def self.get_cars(current_user)
    query = "{
      fetchUserCars(userId: #{current_user}) {
        userId
        make
        fuelType
        model
        year
      }
    }"
    require "pry"; binding.pry

    make_request(query)
  end

  def self.make_request(query)
    header_hash = {
      "Content-Type": "application/json"
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({query: query}), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end
end
