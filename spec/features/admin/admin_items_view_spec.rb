require_relative '../feature_spec_helper'

describe "admin items view", type: :feature do
  it 'has a list of menu items' do
    # there's got to be a better way!  (gems)
    item1 = build_item(title: "Food", description: "Doe", price: 100.00)
    item2 = build_item(title: "MoreFood", description: "John", price: 150.00)
    item3 = build_item(title: "Foood", description: "Jane", price: 200.00)

    visit admin_items_path
    expect(page).to have_content item1.title
    expect(page).to have_content item2.description
    expect(page).to have_content item3.price
  end

  it 'has a link to view an individual item' do
    item = build_item(valid_params)

    visit admin_items_path
    expect(page).to have_link "View Item", href:admin_item_path(item)
  end

  it 'has a link to edit an item' do
    item = build_item(valid_params)

    visit admin_items_path
    expect(page).to have_link "Edit Item", href:edit_admin_item_path(item)
  end

  it 'has a link to delete an item' do
    item = build_item(valid_params)

    visit admin_items_path
    expect(page).to have_link "Delete Item", href:admin_item_path(item)
  end

  def valid_params
    {
      title: "John",
      description: "Doe",
      price: 20.00
    }
  end

  def build_item(options={})
    Item.create(options)
  end
end