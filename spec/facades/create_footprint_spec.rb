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
end
