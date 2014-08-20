require_relative 'feature_spec_helper'


describe "signup" do
  before do
    visit "/"
    first(:link, "Signup").click
  end

  describe "with valid parameters" do
    it "should create a new user" do
        fill_in( "first name",            :with => "John")
        fill_in( "last name",             :with => "Doe")
        fill_in( "email address",         :with => "john@example.com" )
        fill_in( "password",              :with => "swordfish" )
        fill_in( "password confirmation", :with => "swordfish" )

        expect { click_button("Create my account") }.to change(User, :count).by(1)
    end
  end

  describe "when the form is submitted with invalid parameters" do
    it "should give a pleasant error message" do
      click_button("Create my account")

      #We want the page to display an informative error
      expect(page).to have_content("Forms can not be left blank")
    end
  end

end
