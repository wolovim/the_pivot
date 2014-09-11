require_relative 'feature_spec_helper'

describe 'user', type: :feature do
  it 'creates a new account' do
    visit '/signup'
    # save_and_open_page

    fill_in "First Name", with: "Jon"
    fill_in "Last Name", with: "Snow"
    fill_in "Email Address", with: "jonsnow@whitewall.gov"
    fill_in "City", with: "Denver"
    fill_in "State", with: "Colorado"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_on "Create my account"

    expect(page).to have_content "Jon"
  end
end
