require_relative 'feature_spec_helper'

describe "a user goes to the login page" do
  user = User.new(first_name: "")

  before do
    visit "/"
    first(:link, "Login").click
  end

  describe "with valid parameters" do
    it "should login to their account" do
      fill_in( "email address", :with => "a@example.com" )
      fill_in( "password",      :with => "123456789" )
      click_button("Login")
      save_and_open_page
      expect(page).to have_content("Your Cart")
    end
  end
end
