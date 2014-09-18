require_relative 'feature_spec_helper'

describe "a user goes to the login page" do
  before do
    create(:user, email: "j@example.com")
    visit "/"
    first(:link, "Login").click
  end

  describe "with valid parameters" do
    it "should login to their account" do
      fill_in( "email address", :with => "j@example.com" )
      fill_in( "password",      :with => "123456789" )
      click_button("Login")

      expect(page).to have_content("John")
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
