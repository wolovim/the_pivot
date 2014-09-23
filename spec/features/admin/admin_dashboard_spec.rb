require_relative '../feature_spec_helper'

describe "admin", type: :feature do

  it "is redirected to the admin dashboard upon loggin in" do
    user = FactoryGirl.create :user, role: "admin"

    visit '/login'
    fill_in "email address", with: user.email
    fill_in "password", with: user.password
    click_button "Login" 

    expect(current_path).to eq admin_dashboard_path 
  end

  it 'has the correct links' do
    user = FactoryGirl.create :user, role: "admin"

    visit '/login'
    fill_in "email address", with: user.email
    fill_in "password", with: user.password
    click_button "Login" 

    expect(page).to have_link "Users", href: admin_users_path
    expect(page).to have_link "Listings", href: admin_items_path
  end
end
