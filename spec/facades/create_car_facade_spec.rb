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
end
