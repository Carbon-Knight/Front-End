require 'rails_helper'

describe CarMonthlyMileageFacade do
  it 'Returns all users car monthly mileages' do
    current_user = create(:user)
    file = File.read('spec/fixtures/get_car_monthly_mileages.json')
    car_monthly_mileages = JSON.parse(file, symbolize_names: true)[:data][:fetchAllUserCarMonthlyMileages]

    allow(CarMonthlyMileageService).to receive(:get_car_monthly_mileages).with(current_user).and_return(car_monthly_mileages)
    result = CarMonthlyMileageFacade.get_car_monthly_mileages(current_user)
    first = result[0]
    expect(result).to be_a(Array)
    expect(first).to be_a(CarMonthlyMileage)
  end
end
