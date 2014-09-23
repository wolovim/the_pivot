require_relative 'feature_spec_helper'

describe "host", type: :feature do

  it "creates a new listing" do
    user = create :user, role: "default"

    visit "/login"

    fill_in "email address", with: user.email
    fill_in "password", with: user.password

    click_button "Login"
    click_link_or_button "My Dashboard"
    click_link_or_button "Create a New Listing"

    fill_in "item_title", with: "NewListingTitle"
    fill_in "item_description", with: "NewListingDescription"
    fill_in "item_price", with: 20
    find('#item_people_per_unit').find(:xpath, 'option[2]').select_option
    find('#item_bathroom').find(:xpath, 'option[2]').select_option
    fill_in "from", with: "04/10/2014"
    fill_in "to", with: "04/11/2014"
    click_button "Continue"

    fill_in "Street 1", with: "MyStreet"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zipcode", with: 90210
    click_button "Continue"

    attach_file "item_image_image", "spec/fixtures/missing.jpg"
    click_link_or_button "Upload Photo"
    click_link_or_button "I'm finished"

    within(".item-show-title") { expect(page).to have_content "NewListingTitle" }
    within(".location-info") { expect(page).to have_content "NewListingDescription" }
  end
end
