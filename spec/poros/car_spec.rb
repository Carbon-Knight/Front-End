require 'rails_helper'

describe Car do
  it "Exists and has attributes" do
    car_info = {id: 1, make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:20010}
    car_poro = Car.new(car_info)

    expect(car_poro.car_id).to eq(car_info[:id])
    expect(car_poro.make).to eq(car_info[:make])
    expect(car_poro.model).to eq(car_info[:model])
    expect(car_poro.year).to eq(car_info[:year])
    expect(car_poro.mpg).to eq(car_info[:mpg])
    expect(car_poro.fuel_type).to eq(car_info[:fuelType])
  end
end
