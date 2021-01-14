require 'rails_helper'

describe Footprint do
  it "Exists and has attributes" do
    footprint_info = {month: 'February', carbonInKg: 45.12}
    year = 2021

    footprint_poro = Footprint.new(footprint_info, year)

    expect(footprint_poro.month).to eq(footprint_info[:month])
    expect(footprint_poro.year).to eq(year)
    expect(footprint_poro.carbon_in_kg).to eq(footprint_info[:carbonInKg])
  end
  it 'Changes nil to zero' do
    footprint_info = {month: 'February', carbonInKg: nil}
    year = 2021

    footprint_poro = Footprint.new(footprint_info, year)

    expect(footprint_poro.carbon_in_kg).to eq(0)
  end

  it 'can calculate the total carbon for footprints' do 
    footprints = [["January", 10], ["February", 10],["March", 10],
    ["April", 10],["May", 10],["June", 10],["July", 10],
    ["August", 10],["September", 10],["October", 10],["November", 10],
    ["December", 10]]

    result = Footprint.total_carbon_for_year(footprints)

    expect(result).to eq(120)
  end
end
