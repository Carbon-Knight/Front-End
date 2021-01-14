require 'rails_helper'

describe 'User Dashboard' do
  describe "As a visitor" do
    it "I am unable to visit the dashboard" do
      visit dashboard_path
      expect(current_path).to eq('/')
      expect(page).to have_content("Please log in")
    end
  end

  describe 'As a User' do
    describe 'When visiting the dashboard page' do
      before :each do
        @user = create(:user, name: 'Mr. Fake')
        user_data = stub_omniauth
        @user = User.find_or_create_by(uid: user_data[:uid])
        @user.name = user_data[:info][:name]
        @user.email = user_data[:info][:email]
        @user.token = user_data[:credentials][:token]
        @user.image = user_data[:info][:image]
        @user.save
        @url = ENV['HOST_URL']

        @year = Time.now.year
        footprint_years = [2018, 2019, 2020, 2021]

        stub_request(:post, @url).to_return(
          status: 200,
          body: File.read('spec/fixtures/get_footprints.json')
        )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        allow(FootprintFacade).to receive(:get_user_footprint_years).with(@user).and_return(footprint_years)

        visit dashboard_path
      end

      it 'Has a users google information on the page' do
        expect(page).to have_content(@user.name)
        expect(page).to have_css("img[src*='#{@user.image}']")
      end

      it 'Has links from the nav application layout' do
        within '.nav' do
          expect(page).to have_link('Home')
          expect(page).to have_link('Friends')
          expect(page).to have_link('Carbon Calculator')
          expect(page).to have_link('Offsets')
          expect(page).to have_link('Resources')
          expect(page).to have_link('Log Out')
        end
      end

      it 'has links for the leader board and carbon calculator' do
        within '#user-carbon-data' do
          expect(page).to have_link('Visit Leader Board Here')
          expect(page).to have_link('Input Vehicle Data Here')
        end
      end

      it 'I see my previous footprint data' do
        expect(page).to have_content("Your Carbon Footprint For #{@year} Is:")
        expect(page).to have_css('#charts')
        within('#charts') do
          expect(page).to have_css('#graph')
          graph_data = find('#graph').text
          expect(graph_data).to_not be_empty
        end
      end

      xit 'If a user has data saved, a drop down to view a selected year is visable' do
        year = Time.now.year
        expect(page).to have_content("Your Carbon Footprint For #{year} Is:")
        expect(page).to have_css('.select-year-dropdown')
        expect(page).to have_select(:footprint_year, :options => ['2018', '2019', '2020', '2021'])
      end

      xit 'when a user selects a year, they are redirected to the dashboard and see the graph for that year' do
        expect(page).to have_content("Your Carbon Footprint For #{@year} Is:")
        #TODO add test for specific results before change graph

        select '2018', :from => :footprint_year

        stub_request(:post, @url).to_return(
          status: 200,
          body: File.read('spec/fixtures/get_footprints_2.json')
        )

        click_button 'Select Footprint Year'
        year = 2018
        expect(page).to have_content("Your Carbon Footprint For #{year} Is:")

        #TODO add the resulting data for the new graph
      end
      it 'I see my total carbon for the year' do
        year = 2021
        expect(page).to have_css('.total-carbon-year')
        save_and_open_page
        within('.total-carbon-year') do
          expect(page).to have_content("Total(#{year}): 95.62")
        end
      end
    end
  end
end
