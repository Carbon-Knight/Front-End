require 'rails_helper' 

RSpec.describe FootprintFacade do 
  it 'returns an array of footprint objects in order' do 
    year = '2021'
    current_user = create(:user)
    file = File.read('spec/fixtures/get_footprints.json')
    footprints = JSON.parse(file, symbolize_names: true)[:data][:fetchUserFootprints][:footprints]
    
    allow(FootprintService).to receive(:get_footprints).with(year, current_user).and_return(footprints)

    result = FootprintFacade.get_footprints(year, current_user)
    first = result[0]
    
    expect(result).to be_a(Array)
    expect(first).to be_a(Footprint)
  end
end
