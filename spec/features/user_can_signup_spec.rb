require_relative 'feature_spec_helper'

describe "signup" do
  describe "with valid parameters" do
    it "should create a new user" do
      visit "/"
      save_and_open_page
      first(:link, "Signup").click
      within('#signup') do
        fill_in( "Full name",           :with => "John Doe")
        fill_in( "Enter email",         :with => "john@example.com" )
        fill_in( "Password",            :with => "swordfish" )
        # fill_in( "Password confirmation", :with => "swordfish" )

        expect { click_link("Signup") }.to change(User, :count).by(1)
      end
    end
  end
end
