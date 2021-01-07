require 'rails_helper'

describe "Welcome Page" do
  describe "Index" do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        {"provider"=>"google_oauth2",
          "uid"=>"7",
          "info"=>
          {"name"=>"Mr. Fake",
            "email"=>"fake@gmail.com",
            "unverified_email"=>"fake@gmail.com",
            "email_verified"=>true,
            "first_name"=>"Mr",
            "last_name"=>"Fake",
            "image"=>
            "https://lh3.googleusercontent.com/-kqGmu-  P5-WY/AAAAAAAAAAI/AAAAAAAAAAA/  AMZuuclk2PmeS8Y7L_muMqizTWLXSUA5ag/s96-c/photo.jpg"},
            "credentials"=>
            {"token"=>
              "token",
              "expires_at"=>12,
              "expires"=>true}
            }
          )
    end
    it "Welcomes visitor w/ a login" do
      visit root_path

      expect(page).to have_content("Welcome")
      expect(page).to have_link("Login with Google")
    end

    it "Logs in/ registers with google OAuth" do

      visit root_path
      click_link "Login with Google"
      expect(current_path).to eq(dashboard_path)
      
    end
  end
end
