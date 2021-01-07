module OmniauthMacros
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
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
end
