require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  let(:current_order) { Order.create!(delivery: true) }
  it 'starts with zero items' do
    visit order_path(current_order)

    expect(page).to have_content("Your order is empty")
  end

  it 'can add an item' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100.00)
    item.categories.create(name: 'africa')
    visit items_path
    click_button("Add to Cart")
    visit order_path(current_order)
    expect(page).to have_content("John")
  end

  it 'can remove an item' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100.00)
    visit item_path(item)
    click_button("Add to Cart")
    visit order_path(current_order)
    click_button("Remove from Cart")
    expect(page).not_to have_content("John")
    expect(page).not_to have_content("Remove")
  end

  it 'can change an item quantity from the order page' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100.00)
    visit item_path(item)
    click_button("Add to Cart")
    visit order_path(current_order)
    expect(page).to have_content("Quantity")
  end
end
