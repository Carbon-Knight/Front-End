class CarMonthlyMileageService
  def self.get_car_monthly_mileages(current_user)
    query = "query {
          fetchAllUserCarMonthlyMileages(user_id: #{current_user.id}) {
              id,
              month,
              year,
              totalMileage
          }
        }
      }"
    make_request(query)[:data][:fetchAllUserCarMonthlyMileages]
  end

  def self.make_request(query)
    header_hash = {
      "Content-Type": 'application/json'
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({ query: query }), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end
end
