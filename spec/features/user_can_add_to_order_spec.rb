require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  let(:current_order) { Order.create!(delivery: true) }
  it 'starts with zero items' do
    visit order_path(current_order)

    expect(page).to have_content("Your order is empty")
  end

  it 'can add an item' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100.00)
    visit item_path(item)
    click_button("Add to Cart")
    visit order_path(current_order)
    expect(page).to have_content("John")
  end

  xit 'can remove an item' do
    #these tests could probably be rewritten
    item = Item.create!(title: 'John', description: 'Doe', price: 100.00)
    visit item_path(item)
    click_button("Add to Cart")
    visit order_path(current_order)
    expect(page).to have_content("Remove")
    click_link("Remove")
    expect(page).not_to have_content("John")
    expect(page).not_to have_content("Remove")
  end

  xit 'can update the quantity of an item' do
  end
end
