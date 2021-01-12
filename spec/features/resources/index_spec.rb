require 'rails_helper'

describe 'Resources Page' do
  describe 'As a visitor' do
    before :each do
      visit '/resources'
    end

    it 'I can see all the resources on the page' do
      expect(page).to have_css('#resources-header')
      exxpect(page)to have_css('#list-group')
    end

    it 'A resource has description, image, and links to site' do
      # within '#TNC' do
      #   expect(page
      end
    end
  end
end
