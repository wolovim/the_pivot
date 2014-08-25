require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end
  
  it 'adds a category to an item' do
    item = Item.create(title: "hi", description: "mom", price: 10)
    category = Category.create(name: "Dinner")
    item.categories.create(name: "Lunch")

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    first(:link, "View Item").click

    expect(page).not_to have_css ".current-categories", text: "Dinner"
    click_link 'Dinner'
    expect(current_url).to eq "http://www.example.com/admin/items/1"
    expect(page).to have_css ".current-categories", text: "Dinner"
  end
end
