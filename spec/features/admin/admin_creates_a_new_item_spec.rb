require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
   before do
     admin = create(:user)
     visit login_path
     fill_in 'email address', :with => admin.email
     fill_in 'password', :with => admin.password
     click_button("Login")
   end

  it 'creates a new menu item' do
    item = Item.create(title: "John", description: "doe", price: 10.00)

    visit '/admin_dashboard'
    click_link "Create New Item"
    fill_in "Title", with: "NewItem"
    fill_in "Description", with: "NewItemDescription"
    fill_in "Price", with: 20.00
    click_button "Create Item"

    expect(page).to have_content "NewItem"
    expect(page).to have_content "NewItemDescription"
  end
end
