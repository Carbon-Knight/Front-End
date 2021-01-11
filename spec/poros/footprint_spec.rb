require 'rails_helper'

describe Footprint do
  it "Exists and has attributes" do
    car_info = {make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:20010}
    car = Car.new(car_info)
    footprint_info = {car_id: car, total_mileage: 204, month: 'February', year: '2020'}
    footprint_poro = Footprint.new(footprint_info)
    
    expect(footprint_poro.car_id).to eq(footprint_info[:car_id])
    expect(footprint_poro.total_mileage).to eq(footprint_info[:total_mileage])
    expect(footprint_poro.month).to eq(footprint_info[:month])
    expect(footprint_poro.year).to eq(footprint_info[:year])
  end
end
