# README

## Getting Started
1. Clone this repo `git clone https://github.com/Carbon-Knight/Front-End.git`
2. Enter the directory it was cloned into `cd Front-End`
3. Run `bundle install` to install gems and dependencies
4. Run `bundle exec rails db:{create,migrate}` to set up the database
5. Run `bundle exec figaro install`
  * Add `GOOGLE_CLIENT_ID: <ID HERE>` to the `config/application.yml` file created
    by figaro
  * Add `GOOGLE_CLIENT_SECRET: <SECRET HERE>` to the above file

## Adding a New User Car 
1. Click on Carbon Calculator in the Navigation Bar
![Navigate to the Carbon Calculator](app/assets/images/dashboard/click_carbon_footprint_calculator.png)
    - Image left for future reference when adding actual images (after styling is done)
1. Click 'Add a Car' link to navigate to the new car form 
1. Complete the required fields for a new car (Make, Model, Year, Fuel efficiency), Fuel type 
1. Click 'Add Vehicle' once all fields have been completed (an error message will display otherwise)
   - You will be redirected back to the carbon footprint calculator 
1. Added car will be visible within the car selection drop down 
