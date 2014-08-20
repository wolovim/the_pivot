require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  it 'creates a new menu item' do
    item = Item.create(title: "John", description: "doe", price: 10.00)

    visit '/admin_dashboard'
    click_link "Create New Item"
    fill_in "Title", with: "NewItem"
    fill_in "Description", with: "NewItemDescription"
    fill_in "Price", with: 20.00
    click_button "Create Item"

    expect(page).to have_content "NewItemDescription"
  end
end