require_relative 'feature_spec_helper'

describe 'user', type: :feature do
  it 'creates a new account' do
    visit '/signup'
    # save_and_open_page

    fill_in "first name", with: "Jon"
    fill_in "last name", with: "Snow"
    fill_in "email address", with: "jonsnow@whitewall.gov"
    fill_in "username", with: "jonsnow"
    fill_in "password", with: "password"
    fill_in "password confirmation", with: "password"
    click_on "Create my account"

    expect(page).to have_content "Jon"
  end
end
