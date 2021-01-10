class CarService
  def self.new_car(car_params, current_user)
    query = "mutation {
       createUserCar(input: {
         userId: #{current_user.id},
         make: \"#{car_params[:make]}\",
         model: \"#{car_params[:model]}\",
         year: #{car_params[:year]},
         mpg: #{car_params[:mpg]},
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
      query = "query {
        fetchUserCars(userId: #{current_user.id}) {
          make,
          model,
          year,
          mpg,
          fuelType
        }
      }"
      make_request(query)[:data][:fetchUserCars]
  end

  def self.make_request(query)
    header_hash = {
      "Content-Type": "application/json"
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({query: query}), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end
end
