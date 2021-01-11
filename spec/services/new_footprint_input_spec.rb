require 'rails_helper'

describe FootprintService do
  let(:url) { ENV['HOST_URL'] }

  before do
    stub_request(:post, url).to_return(
      status: 200,
      body: File.read('spec/fixtures/new_footprint.json')
    )
  end

  it 'returns parsed JSON data for a new footprint input' do
    
  end
end
