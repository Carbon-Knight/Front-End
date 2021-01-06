require 'rails_helper'

describe "Welcome Page" do
  describe "Index" do
    it "Welcomes visitor w/ a login" do
      visit root_path

      expect(page).to have("Welcome")
      expect(page).to have_link("Login with Google")
    end
  end
end
