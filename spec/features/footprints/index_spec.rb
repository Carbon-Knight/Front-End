require 'rails_helper'

describe 'Footprint Index Page' do
  describe 'As an authenticated user' do
    let(:url) { ENV['HOST_URL'] }

    before :each do
      @user = create(:user, uid: '3')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      # stub_request(:post, url).to_return(
      #   status: 200,
      #   body: File.read('spec/fixtures/get_cars.json')
      # )
    end

    it 'I can click the link to view previous footprints' do
      visit '/dashboard'
      click_link('View Previous Footprints')
      expect(current_path).to eq('/footprints')
      within '.footprint-header' do
        expect(page).to have_content('Your Previous Carbon Footprints')
      end
    end
  end
end
