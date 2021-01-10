require 'rails_helper'

describe CarsFacade do
  it "can return all the current_user's cars" do
    current_user = create(:user)
    cars =[{make:"subaru",mpg:25,fuelType:"gasoline",model:"forester",year:20010},{make:"Toyotal",mpg:18,fuelType:"gasoline",model:"Tundra",year:2000}]

    allow(CarService).to receive(:get_cars).with(current_user).and_return(cars)
    result = CarsFacade.get_cars(current_user)

    expect(result).to be_a(Array)
    expect(result.first).to be_a(Car)
  end
end
