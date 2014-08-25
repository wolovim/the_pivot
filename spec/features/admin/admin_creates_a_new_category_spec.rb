require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end

  xit 'creates a new category' do
    item1 = Item.create(title: "Food", description: "Yum", price: 20)
    item2 = Item.create(title: "MoarFood", description: "Yummer", price: 20)
    item1.categories.new(name: "Lunch")
    item1.categories.new(name: "Dinner")
    item2.categories.new(name: "Lunch")

    visit '/admin_dashboard'
    click_link "Create New Category"
    fill_in "Name", with: "Small Plates"
    click_button "Create Category"

    expect(current_url).to eq "http://www.example.com/admin/items"
    expect(page).to have_content "Small Plates"
  end

end
