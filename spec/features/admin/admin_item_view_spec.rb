require_relative '../feature_spec_helper'

describe 'the admin item view', type: :feature do
  it 'displays the information for the correct item' do
    item = Item.create(title: "Food", description: "Yum", price: 20.00)

    visit admin_items_path
    click_link "View Item"
    expect(current_url).to eq "http://www.example.com/admin/items/1"
    expect(page).to have_content item.title
  end
end