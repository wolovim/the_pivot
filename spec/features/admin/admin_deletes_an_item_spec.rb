require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  it 'deletes a menu item' do
    item = build_item(title: "Hi", description: "Hello", price: 100)
    item.categories.create(name: "Lunch")

    # not sure how necessary these steps are, would it make sense
    # to go straight to admin_item_path(item)?
    visit '/admin_dashboard'
    click_link 'View Menu Items'
    expect(page).to have_content "Hello"
    first(:link, "Delete Item").click
    expect(page).not_to have_content "Hello"
  end

  def build_item(options={})
    Item.create(options) 
  end
end