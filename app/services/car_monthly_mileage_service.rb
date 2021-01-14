class CarMonthlyMileageService
  def self.get_car_monthly_mileages(current_user)
    query = "query {
          fetchAllUserCarMonthlyMileages(userId: #{current_user.id}) {
              id
              month
              year
              totalMileage
          }
        }"
    make_request(query)[:data][:fetchAllUserCarMonthlyMileages]
  end

  def self.update_car_monthly_mileage(car_monthly_mileage, footprint_params)
    query = "mutation {
      updateCarMonthlyMileage(input:{
        id: #{car_monthly_mileage.id},
        totalMileage: #{footprint_params[:total_mileage].to_i},
        month: #{car_monthly_mileage.month},
        year: #{car_monthly_mileage.year}
        }) {
          footprint {
            carbonInKg
            offsetCostTotal
            offsetCostCurrency
          }
        }
      }"
  end

  def self.make_request(query)
    header_hash = {
      "Content-Type": 'application/json'
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({ query: query }), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end
end
