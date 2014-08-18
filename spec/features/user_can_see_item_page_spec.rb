require_relative 'feature_spec_helper'

describe 'an items show page', type: :feature do
  let(:item) { Item.create!(title: 'John', description: 'Doe', price: 100.00) }
  it 'has a show page for an item' do
    visit item_path(item)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("John")
  end

  it "has an add to order button" do
    visit item_path(item)
    expect(page).to have_content('Add to Cart')
  end
end
