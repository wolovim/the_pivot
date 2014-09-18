require_relative 'feature_spec_helper'

describe 'host', type: :feature do

  xit 'creates a first listing' do
    user = create :user, role: "default"

    visit user_path(user)
    click_link 'Create your first listing'
    expect(current_path). to eq new_admin_item_path

    fill_in "Title", with: "NewListingTitle"
    fill_in "Description", with: "NewListingDescription"
    fill_in "Price", with: 20
    fill_in "People per unit", with: 1
    fill_in "Bathroom", with: "private"
    click_button "Create Listing"

    expect(page).to have_content "NewListingTitle"
    expect(page).to have_content "NewListingDescription"
  end

  it 'creates a new listing' do
    user = create :user, role: "default"

    visit '/login'
    fill_in 'email address', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'

    visit dashboard_user_path(user)

    click_link "Create a New Listing"
    expect(current_path).to eq new_item_path

    fill_in "Listing Title", with: "NewListingTitle"
    fill_in "Listing Description", with: "NewListingDescription"
    fill_in "Daily Rate", with: 20
    find('#item_people_per_unit').find(:xpath, 'option[2]').select_option
    find('#item_bathroom').find(:xpath, 'option[2]').select_option
    fill_in "from", with: "04/10/2014"
    fill_in "to", with: "04/11/2014"
    click_button "Continue"

    attach_file "item_image_image", 'spec/fixtures/missing.jpg'
    click_link_or_button "Upload Photo"
    click_link_or_button "I'm finished"

    within(".location_title") { expect(page).to have_content "NewListingTitle" }
    within(".location_info") { expect(page)
                               .to have_content "NewListingDescription" }
  end
end
