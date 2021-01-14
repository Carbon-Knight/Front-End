require 'rails_helper'

describe 'Resources Page' do
  describe 'As a visitor' do
    before :each do
      visit '/resources'
    end

    it 'I can see all the resources on the page' do
      expect(page).to have_css('#resources-header')
      expect(page).to have_css('.list-group')
    end

    it 'A resource has description, image, and links to site' do
      within '.TNC' do
        href = 'https://www.nature.org/en-us/get-involved/how-to-help/carbon-footprint-calculator/#:~:text=A%20carbon%20footprint%20is%20the,highest%20rates%20in%20the%20world.'
        page.should have_selector "a[href='#{href}']"
        expect(page).to have_css("img[src*='https://www.nature.org/content/dam/tnc/nature/en/logos/tnc-logo.svg']")
      end
    end
  end
end
