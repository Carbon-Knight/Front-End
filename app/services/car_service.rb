class CarService 
  def self.new_car(car_params, current_user)
    query = format_query(car_params, current_user)
    # query = '
    #     mutation {
    #       createUserCar(input: {
    #         userId: 1, make: "Toyota", model: "Four Runner", year: "2000", mpg: 20, fuelType: "gasoline"
    #       }) {
    #         car {
    #           userId
    #         }
    #       }
    #     }
    #     '

    header_hash = {
      "Content-Type": "application/json"
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({query: query}), header_hash)
    require 'pry'; binding.pry
  end

  # def self.conn()
  #   Graphlient::Client.new(ENV['HOST_URL'])
  # end

  def self.format_query(car_params, current_user)
    query = "mutation { 
      createUserCar(input: { 
        userId: #{current_user.id}, make: #{car_params[:make]}, model: #{car_params[:year]}, mpg: #{car_params[:mpg].to_i}, fuelType: #{car_params[:fuel_type]}
        }) {
          car {
            userID
          }
        }
        }"
    # {
    #   userId: current_user.id,
    #   make: car_params[:make],
    #   model: car_params[:model],
    #   year: car_params[:year],
    #   mpg: car_params[:mpg].to_i,
    #   fuelType: car_params[:fuel_type],
    # }
  end
end
