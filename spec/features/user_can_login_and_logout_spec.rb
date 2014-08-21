require_relative 'feature_spec_helper'

describe "a user goes to the login page" do
  user = User.new
  user.first_name = "John"
  user.last_name  = "Doe"
  user.email      = "j@example.com"
  user.password   = "123456789"
  user.save

  before do
    visit "/"
    first(:link, "Login").click
  end

  describe "with valid parameters" do
    it "should login to their account" do
      fill_in( "email address", :with => "j@example.com" )
      fill_in( "password",      :with => "123456789" )
      click_button("Login")

<<<<<<< HEAD:spec/features/user_can_login_and_logout_spec.rb
      expect(page).to have_content("Your Info")
||||||| merged common ancestors
      expect(page).to have_content("Your Cart")
=======
      expect(page).to have_content("My Order")
>>>>>>> b2a88bc87a3f8f0be6c03095074cf364ac048410:spec/features/user_can_login_spec.rb
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
