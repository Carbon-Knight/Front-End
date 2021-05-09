require 'rails_helper'

describe CarMonthlyMileage do
  it 'Exists and has attributes' do
    service_response = {
      id: 1,
      month: 'June',
      year: 2020,
      totalMileage: 12_345,
      car: {
        id: 2,
        make: 'Dodge',
        model: 'Dakota',
        year: '1992'
      }
    }
    car_monthly_mileages = CarMonthlyMileage.new(service_response)
    expect(car_monthly_mileages.id).to eq(service_response[:id])
    expect(car_monthly_mileages.month).to eq(service_response[:month])
    expect(car_monthly_mileages.year).to eq(service_response[:year])
    expect(car_monthly_mileages.total_mileage).to eq(service_response[:totalMileage])
    expect(car_monthly_mileages.car).to be_a(Car)
    expect(car_monthly_mileages.car.car_id).to eq(service_response[:car][:id])
    expect(car_monthly_mileages.car.year).to eq(service_response[:car][:year])
    expect(car_monthly_mileages.car.model).to eq(service_response[:car][:model])
    expect(car_monthly_mileages.car.make).to eq(service_response[:car][:make])
  end
end
