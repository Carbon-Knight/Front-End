class CarService 
  def self.new_car(car_params, current_user)
    params = format_params(car_params, current_user)
    conn.query do 
      mutation do 
        createUserCar(input: params) do 
          car {
            userId
          }
        end
      end
    end
  end

  def self.conn()
    Graphlient::Client.new(ENV['HOST_URL'])
  end

  def self.format_params(car_params, current_user)
    {
      userId: current_user.id,
      make: car_params[:make],
      model: car_params[:model],
      year: car_params[:year],
      mpg: car_params[:mpg].to_i,
      fuelType: car_params[:fuel_type],
    }
  end
end
