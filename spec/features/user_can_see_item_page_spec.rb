require_relative 'feature_spec_helper'

describe 'an items show page', type: :feature do
  it 'has a show page for an item' do
    item = Item.create(title: 'John', description: 'Doe', price: 100.00)
    visit items_path(item)

    # save_and_open_page
    expect(page.status_code).to eq(200)
    expect(current_path).to eq(items_path(item))
    # expect(page).to have_content("John")
  end
end