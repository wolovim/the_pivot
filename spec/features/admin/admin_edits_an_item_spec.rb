require_relative '../feature_spec_helper'

describe 'admin edits an item', type: :feature do
  include AdminHelper

  before { login_as_admin }

  it 'edits a menu item' do
    item = create :item, :title => "hi"
    item.item_images.create!


    visit '/admin_dashboard'
    click_link 'View Menu Items'
    first(:link, "Edit Item").click
    fill_in "Title", with: "NewTitle"
    fill_in "Description", with: "NewDescription"
    fill_in "Price", with: 100
    click_button "Update Item"

    expect(page).to have_content "NewTitle"
    expect(page).not_to have_content "hi"
  end
end
