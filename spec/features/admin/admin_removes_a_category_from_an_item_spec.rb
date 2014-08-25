require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  # Needs refactoring the way things are now (links to add categories
  # are on the show page).
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end
  
  it 'removes a category from a menu item' do
    item = Item.create(title: "hi", description: "mom", price: 10)
    item.categories.create(name: "Lunch")

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    first(:link, "View Item").click

    # use css here, target the list of current categories
    expect(page).to have_css ".current-categories", text: "Lunch"
    click_link 'Remove Category'
    expect(page).not_to have_css ".current-categories", text: "Lunch"
  end
end
