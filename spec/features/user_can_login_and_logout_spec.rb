require_relative 'feature_spec_helper'

describe "a user goes to the login page" do
  before do
    create :user
    visit "/"
    first(:link, "Login").click
  end

  describe "with valid parameters" do
    it "should login to their account" do
      fill_in( "email address", :with => "john@example.com" )
      fill_in( "password",      :with => "swordfish" )
      click_button("Login")

      # Any way to verify user specific things?
      expect(page).to have_content("Your Info")
    end
  end

  describe "with invalid parameters" do
    it "should render a new login template with a friendly error message" do
      click_button("Login")

      expect(page).to have_content("Invalid email/password combination")
      expect(page).to have_content("Login.")
    end
  end
end
