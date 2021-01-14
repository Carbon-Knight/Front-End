class FootprintService
  def self.new_footprint(footprint_params, _current_user)
    query = "mutation {
        createFootprintAndCarMonthlyMileage(input: {
          carId: \"#{footprint_params[:car_id]}\",
          totalMileage: #{footprint_params[:total_mileage]},
          month: \"#{footprint_params[:month]}\",
          year: \"#{footprint_params[:year]}\"
        }) {
            footprint {
              id
            }
          }
    }"
    make_request(query)
  end

  def self.get_footprints(year, current_user)
    query = "query
    {
      fetchUserFootprint(input: {
        user_id: #{current_user.id},
        year: #{year}
      ) {
          footprints 
          { 
            month 
            carbonInKg
          }
        }
      }
    }"
    make_request(query)[:data][:fetchUserAggregateFootprintForYear][:footprints]
  end

  def self.get_user_footprint_years(current_user)
    query = "query
    {
      fetchUserFootprintYears(userId: #{current_user.id}) 
      { 
          years
        }
    }"
    make_request(query)[:data][:fetchUserFootprintYears][:years]
  end

  def self.make_request(query)
    header_hash = {
      "Content-Type": 'application/json'
    }

    result = Faraday.post(ENV['HOST_URL'], JSON.generate({ query: query }), header_hash)

    JSON.parse(result.body, symbolize_names: true)
  end
end
