require_relative "../feature_spec_helper"

describe "non-admin", type: :feature do
  let(:user) { FactoryGirl.create :user, role: "user" }

  before do
    visit "/login"

    fill_in "email address", with: user.email
    fill_in "password", with: user.password

    click_button "Login"
  end

  it "can't access the admin dashboard" do
    visit '/admin_dashboard'
    expect(page).not_to have_link "Users"
  end

  it "can't acess the admin users page" do
    visit '/admin/users'
    expect(page).not_to have_link "Delete User"
  end

  it "can't access the admin listings page" do
    visit '/admin/items'
    expect(page).not_to have_link "Delete Listing"
  end
end