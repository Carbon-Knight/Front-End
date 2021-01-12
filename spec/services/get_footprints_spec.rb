require 'rails_helper' 

RSpec.describe FootprintService do 
  let(:url) { ENV['HOST_URL']}

  before do 
    stub_request(:post, url).to_return(
      status: 200,
      body: File.read('spec/fixtures/get_footprints.json')
    )
  end

  it 'returns parsed JSON data for a user\'s monthly footprint' do 
    current_user = create(:user)
    year = 2020

    response = FootprintService.get_footprints(current_user, year)

    expect(response).to be_a(Array)
    first = response[0]

    expect(first[:month]).to be_a(String)
    expect(first[:carbon_in_kg]).to be_a(Float)
  end

end
