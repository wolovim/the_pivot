require_relative '../feature_spec_helper'

describe 'admin edits an item', type: :feature do
  xit 'edits a menu item' do
    item = Item.create(title: "hi", description: "asf", price: 10.00)

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    first(:link, "Edit Item").click
    fill_in "Title", with: "NewTitle"
    fill_in "Description", with: "NewDescription"
    fill_in "Price", with: 100.00
    click_button "submit"

    expect(page).to have_content "NewTitle"
  end
end