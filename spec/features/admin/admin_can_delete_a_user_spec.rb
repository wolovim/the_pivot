require_relative "../feature_spec_helper"

describe "admin", type: :feature do

  it 'can delete a user' do
    user = FactoryGirl.create :user, :admin

    visit '/login'
    visit '/login'
    fill_in "email address", with: user.email
    fill_in "password", with: user.password
    click_button "Login"

    click_link_or_button "Users"
  end
end