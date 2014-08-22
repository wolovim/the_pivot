require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  # Needs refactoring the way things are now (links to add categories
  # are on the show page).
  xit 'removes a category from a menu item' do
    item = Item.create(title: "hi", description: "mom", price: 10)
    item.categories.create(name: "Lunch")

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    first(:link, "View Item").click

    expect(page).to have_content "Lunch"
    click_link 'Remove Category'
    expect(current_url).to eq "http://www.example.com" + admin_item_path(item)
    expect(page).not_to have_content "Lunch"
  end
end