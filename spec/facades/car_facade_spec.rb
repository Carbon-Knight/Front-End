require 'rails_helper'

RSpec.describe CarsFacade do

  it 'Can return a created car object' do
    car = {:data=>{:createUserCar=>{:car=>{:userId=>1}}}}
    user = create(:user)

    new_car = {
      :make=>"Ford",
      :model=>"Mustang",
      :year=>"2013",
      :fuel_efficiency=>"24",
      :fuel_type=>"Gasoline"
    }

    allow(CarService).to receive(:new_car).with(new_car, user).and_return(car)
    result = CarsFacade.new_car(new_car, user)

    expect(result).to be_a(Hash)
    expect(result[:data][:createUserCar][:car][:userId]).to be_a(Integer)
  end

  it 'Can return all the current_user\'s cars' do
    current_user = create(:user)
    cars =[{make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:20010},{make:"Toyotal",mpg:18,fuelType:"gasoline",model:"Tundra",year:2000}]

    allow(CarService).to receive(:get_cars).with(current_user).and_return(cars)
    result = CarsFacade.get_cars(current_user)

    expect(result).to be_a(Array)
    expect(result.first).to be_a(Car)
  end
end
