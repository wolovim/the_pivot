require_relative '../feature_spec_helper'

describe 'the admin item view', type: :feature do
  let(:item) {
    item = Item.create(title: "Food", description: "Yum", price: 20)
  }

  before do
    item.categories.create(name: "Lunch")
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end

  it 'displays the information for the correct item' do
    visit admin_item_path(item)

    expect(current_url).to eq "http://www.example.com/admin/items/1"
    expect(page).to have_content item.title
  end

  it 'has a link to edit an item' do
    visit admin_items_path(item)

    expect(page).to have_link "Edit Item", href: edit_admin_item_path(item)
  end
end
