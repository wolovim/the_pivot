require_relative "../feature_spec_helper"

describe "admin", type: :feature do

  it 'can delete a user' do
    admin = FactoryGirl.create :user, :admin
    user1 = FactoryGirl.create :user, last_name: "McCringleberry", role: "user"


    visit '/login'
    visit '/login'
    fill_in "email address", with: admin.email
    fill_in "password", with: admin.password
    click_button "Login"

    click_link_or_button "Users"
    expect(page).to have_content "McCringleberry"

    click_link_or_button "Delete User"
    expect(page).not_to have_content "McCringleberry"
  end
end