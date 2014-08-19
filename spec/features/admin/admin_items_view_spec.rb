require_relative '../feature_spec_helper'

describe "admin items view", type: :feature do
  it 'has a list of menu items' do
    item1 = build_item(title: "Food", description: "Doe", price: 100.00)
    item2 = build_item(title: "MoreFood", description: "John", price: 150.00)
    item3 = build_item(title: "Foood", description: "Jane", price: 200.00)

    visit '/admin_dashboard'
    click_link "View Menu Items"
   expect(page).to have_content(item1.title)
    expect(page).to have_content(item2.description)
    expect(page).to have_content(item3.price)
  end

  def build_item(options={})
    Item.create(options)
  end
end