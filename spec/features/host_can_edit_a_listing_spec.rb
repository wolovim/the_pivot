require_relative 'feature_spec_helper'

describe "host", type: :feature do

  it "edits a listing" do
    user = FactoryGirl.create :user, role: "default"
    item = user.items.create(title: "MyTitle", description: "MyDesc", 
                       bathroom: "Private", people_per_unit: 1, price: 100)
    item.item_images.create(image: File.new("#{Rails.root}/spec/fixtures/bedroom.jpg"))
    item.address = item.create_address(street_1: "street", city: "Denver",
                                       state: "CO", zip: 12345)

    visit "/login"

    fill_in "email address", with: user.email
    fill_in "password", with: user.password

    click_button "Login"
    click_link_or_button "My Dashboard"
    click_link_or_button "Manage Your Current Listings"
    click_link_or_button "Edit Listing"

    fill_in "item_title", with: "NewListingTitle"
    fill_in "item_description", with: "NewListingDescription"
    click_button "Continue"

    fill_in "Street 1", with: "NewStreet"
    fill_in "City", with: "NewCity"
    fill_in "Zipcode", with: 90210
    click_button "Continue"

    click_link_or_button "I'm finished"

    within(".location-info") do
      expect(page).not_to have_content "MyTitle"
      expect(page).not_to have_content "MyDesc"
      expect(page).to have_content "NewListingTitle"
      expect(page).to have_content "NewListingDescription"
    end
  end
end