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

        file = File.read('spec/fixtures/get_footprints.json')
        footprints = JSON.parse(file, symbolize_names: true)[:data][:fetchUserFootprints][:footprints]
        year = Time.now.year
        footprint_years = [2018, 2019, 2020, 2021]

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        allow(FootprintService).to receive(:get_footprints).with(year, @user).and_return(footprints)
        allow(FootprintFacade).to receive(:get_user_footprint_years).with(@user).and_return(footprint_years)

        visit dashboard_path
      end

      it 'Has a users google information on the page' do
        expect(page).to have_content(@user.name)
        expect(page).to have_css("img[src*='#{@user.image}']")
      end

      it 'Has links from the nav application layout' do
        within first '.nav' do
          expect(page).to have_link('Home')
          expect(page).to have_link('Friends')
          expect(page).to have_link('Calculate Footprint')
          expect(page).to have_link('Offsets')
          expect(page).to have_link('Resources')
          expect(page).to have_link('Log Out')
        end
      end

      it 'has links for the leader board and carbon calculator' do
        within '#user-carbon-data' do
          expect(page).to have_link('Visit Leader Board Here')
          expect(page).to have_link('Input Data Here')
        end
      end
      it 'I see my previous footprint data' do
        expect(page).to have_content('Your Carbon Footprint Is:')
        expect(page).to have_css('#charts')
        within('#charts') do
          expect(page).to have_css('#graph')
          graph_data = find('#graph').text
          expect(graph_data).to_not be_empty
        end
      end

      it 'If a user has data saved, a drop down to view a selected year is visable' do
        expect(page).to have_css('.select-year-dropdown')
        expect(page).to have_select(:footprint_year, :options => ['2018', '2019', '2020', '2021'])
      end

      it 'when a user selects a year, they are redirected to the dashboard and see the graph for that year' do
        #TODO add before results for graph
        select '2018', :from => :footprint_year
        click_button 'Select Footprint Year'
        #TODO add the resulting data for the new graph (will need to stub request for 2018 year)

      end
    end
    # describe 'Sad Path' do
    #   before :each do
    #     @user = create(:user, name: 'Mr. Fake')
    #     user_data = stub_omniauth
    #     @user = User.find_or_create_by(uid: user_data[:uid])
    #     @user.name = user_data[:info][:name]
    #     @user.email = user_data[:info][:email]
    #     @user.token = user_data[:credentials][:token]
    #     @user.image = user_data[:info][:image]
    #     @user.save
    #
    #     file = File.read('spec/fixtures/get_null_footprints.json')
    #     footprints = JSON.parse(file, symbolize_names: true)[:data][:fetchUserFootprints][:footprints]
    #     year = Time.now.year
    #     footprint_years = [2018, 2019, 2020, 2021]
    #
    #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    #     allow(FootprintService).to receive(:get_footprints).with(year, @user).and_return(footprints)
    #     allow(FootprintFacade).to receive(:get_user_footprint_years).with(@user).and_return(footprint_years)
    #
    #     visit dashboard_path
    #   end
    #   xit 'I see no previous data when I have not entered any data' do
    #     expect(page).to have_content('Your Carbon Footprint Is:')
    #     expect(page).to have_css('#charts')
    #     within('#charts') do
    #       expect(page).to have_css('#graph')
    #       within('#graph') do
    #         expect(page).to have_content('No Data')
    #       end
    #     end
    #   end
    # end
  end
end
