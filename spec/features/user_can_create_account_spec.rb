require_relative 'feature_spec_helper'

describe 'a site visitor', type: :feature do

  it 'signs up and logs out' do
    visit "/"
    click_link("Signup")
    expect(page).to have_content("Join Today.")

    fill_in( "first name",            :with => "Martha" )
    fill_in( "last name",             :with => "Washington" )
    fill_in( "email address",         :with => "mwashington@thepast.com" )
    fill_in( "password",              :with => "password" )
    fill_in( "password confirmation", :with => "password" )
    click_on("Create my account")

    expect(page).to have_content( "Hello, Martha!")

    click_link("Log out")
    expect(page).to have_content( "Login")
  end

end
