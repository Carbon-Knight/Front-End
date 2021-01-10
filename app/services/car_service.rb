class CarService
  def self.new_car(car_params, current_user)
    query = format_query(car_params, current_user)

    header_hash = {
      "Content-Type": "application/json"
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({query: query}), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end

  def self.format_query(car_params, current_user)
    "mutation {
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
  end
end
