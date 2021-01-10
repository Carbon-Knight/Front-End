require 'rails_helper' 

RSpec.describe CarFacade do 
  it 'Can return a created car object' do 
    new_car = {
      :make=>"Ford", 
      :model=>"Mustang", 
      :year=>"2013", 
      :fuel_efficiency=>"24", 
      :fuel_type=>"Gasoline"
    }

    result = CarFacade.new_car(new_car)

    expect(result).to be_a(Array)
    expect(result[0]).to be_a(Car)
  end
end
