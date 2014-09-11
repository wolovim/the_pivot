require_relative 'feature_spec_helper'

describe 'user', type: :feature do

  it 'signs up and logs out' do
    visit "/"
    click_link("Signup")
    expect(page).to have_content("Join Today.")

    fill_in( "First Name",            :with => "Martha" )
    fill_in( "Last Name",             :with => "Washington" )
    fill_in( "Email Address",         :with => "mwashington@thepast.com" )
    fill_in( "Password",              :with => "password" )
    fill_in( "Password Confirmation", :with => "password" )
    click_on("Create my account")

    expect(page).to have_content( "Welcome, Martha!")

    click_link("Log out")
    expect(page).to have_content( "Login")
  end

end
