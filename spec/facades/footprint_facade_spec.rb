require 'rails_helper'

RSpec.describe FootprintFacade do

  it 'Can return a created footprint object' do
    user = create(:user)
    car_info = {make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:2010}
    car = Car.new(car_info)
    footprint = {:data=>{:createFootprintAndCarMonthlyMileage=>{:footprint=>{:id=>1}}}}

    new_footprint = {
      :car_id=>car,
      :total_mileage=>204,
      :month=>"February",
      :year=>"2020"
    }

    allow(FootprintService).to receive(:new_footprint).with(new_footprint, user).and_return(footprint)
    result = FootprintFacade.new_footprint(new_footprint, user)

    expect(result).to be_a(Hash)
    expect(result[:data][:createFootprintAndCarMonthlyMileage][:footprint][:id]).to be_a(Integer)
  end

  it 'Returns an array of footprint objects in order' do
    year = '2021'
    current_user = create(:user)
    file = File.read('spec/fixtures/get_footprints.json')
    footprints = JSON.parse(file, symbolize_names: true)[:data][:fetchUserAggregateFootprintForYear][:footprints]

    allow(FootprintService).to receive(:get_footprints).with(year, current_user).and_return(footprints)

    results = FootprintFacade.get_footprints(year, current_user)

    expect(results).to be_a(Array)
    results.each do |result|
      expect(result[0]).to be_a(String)
      expect(result[1]).to be_a(Numeric)
    end
  end

  it 'returns an array of years' do 
    current_user = create(:user)
    years = [2010, 2011, 2012]
    allow(FootprintService).to receive(:get_user_footprint_years).with(current_user).and_return(years)
    result = FootprintFacade.get_user_footprint_years(current_user)

    expect(result).to be_a(Array)
    expect(result[0]).to be_a(Integer)
  end
end
