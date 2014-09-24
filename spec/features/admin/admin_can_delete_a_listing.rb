require_relative "../feature_spec_helper"

describe "admin", type: :feature do

  it 'can delete a listing' do
    admin = FactoryGirl.create :user, :admin
    user = FactoryGirl.create :user, last_name: "McCringleberry", role: "user"
    item = FactoryGirl.create :item, user_id: user.id, title: "MyTitle"

    visit '/login'
    fill_in "email address", with: admin.email
    fill_in "password", with: admin.password
    click_button "Login"

    click_link_or_button "Listings"
    expect(page).to have_content "MyTitle"

    click_link_or_button "Delete Listing"
    expect(page).not_to have_content "MyTitle"
  end
end