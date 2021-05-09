class CarMonthlyMileageService
  class << self
    def get_car_monthly_mileages(current_user)
      query = "query {
            fetchAllUserCarMonthlyMileages(userId: #{current_user.id}) {
                id
                month
                year
                totalMileage
                car {
                  make
                  model
                  year
                }
            }
          }"
      make_request(query)[:data][:fetchAllUserCarMonthlyMileages]
    end

    def update_car_monthly_mileage(car_monthly_mileage_id, footprint_params)
      query = "mutation {
        updateCarMonthlyMileage(input:{
          id: #{car_monthly_mileage_id},
          totalMileage: #{footprint_params[:total_mileage].to_i}
          }) {
            footprint {
              carbonInKg
              offsetCostTotal
              offsetCostCurrency
            }
          }
        }"
      make_request(query)
    end

    def get_car_monthly_mileage_by_id(cmm_id)
      query = "query {
                carMonthlyMileage(id: #{cmm_id}) {
                  id
                  month
                  year
                  totalMileage
                  car {
                    make
                    model
                    year
                  }
                }
              }"
      make_request(query)[:data][:carMonthlyMileage]
    end

    private 

    def make_request(query)
      header_hash = {
        "Content-Type": 'application/json'
      }

      result = Faraday.post(ENV['HOST_URL'], JSON.generate({ query: query }), header_hash)
      JSON.parse(result.body, symbolize_names: true)
    end
  end
end
