require 'rails_helper'

describe 'Resources Page' do
  describe 'As a visitor' do
    before :each do
      visit '/resources'
    end

    it 'I can see all the resources on the page' do
      expect(page).to have_css('#resources-header')
    end
  end
end