class FootprintService
  def self.new_footprint(footprint_params, current_user)
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
      }) {  
        footprints 
        {
          [{
            month
            carbon_in_kg
          }]
        }
      }
    }"
    make_request(query)[:data][:fetchUserFootprints][:footprints]
  end
  
  def self.make_request(query)
    header_hash = {
      "Content-Type": "application/json"
    }
  
    result = Faraday.post(ENV['HOST_URL'], JSON.generate({query: query}), header_hash)
    JSON.parse(result.body, symbolize_names: true)
  end
end
