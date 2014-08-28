require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  include AdminHelper

  before { login_as_admin }
  
  it 'adds a category to an item' do
    item = Item.create(title: "hi", description: "mom", price: 10)
    category = Category.create(name: "Dinner")
    item.categories.create(name: "Lunch")

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    click_on item.title

    expect(page).not_to have_css ".categories-container", text: "Dinner"
    click_link 'Dinner'
    expect(current_url).to eq "http://www.example.com/admin/items/1"
    expect(page).to have_css ".categories-container", text: "Dinner"
  end
end
