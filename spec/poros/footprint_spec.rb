require 'rails_helper'

describe Footprint do
  it "Exists and has attributes" do
    footprint_info = {month: 'February', carbon_in_kg: 45.12}
    year = 2021
    
    footprint_poro = Footprint.new(footprint_info, year)

    expect(footprint_poro.month).to eq(footprint_info[:month])
    expect(footprint_poro.year).to eq(year)
    expect(footprint_poro.carbon_in_kg).to eq(footprint_info[:carbon_in_kg])
  end
  it 'Changes nil to zero' do
    footprint_info = {month: 'February', carbon_in_kg: nil}
    year = 2021

    footprint_poro = Footprint.new(footprint_info, year)

    expect(footprint_poro.carbon_in_kg).to eq(0)
  end
end
