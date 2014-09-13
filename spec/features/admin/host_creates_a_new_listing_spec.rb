require_relative '../feature_spec_helper'

describe 'host', type: :feature do
  include AdminHelper

  # before { log_me_in! }

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
    # attach_file "Image", 'spec/fixtures/missing.jpg'
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

    click_link "Host"
    click_link "Create New Listing"
    # save_and_open_page
    fill_in "Listing Title", with: "NewListingTitle"
    fill_in "Listing Description", with: "NewListingDescription"
    fill_in "Daily Rate", with: 20
    # fill_in "People per unit", with: 1
    # fill_in "Bathroom Type: Private or Shared", with: "private"
    # attach_file "Image", 'spec/fixtures/missing.jpg'
    click_button "Create Listing"

    expect(page).to have_content "NewListingTitle"
    expect(page).to have_content "NewListingDescription"
  end
end
