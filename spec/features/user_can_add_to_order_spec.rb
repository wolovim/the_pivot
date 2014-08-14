require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  xit 'starts with zero items' do
    current_order = Order.create
    visit order_path(current_order)

    expect(page).to have_content("Your order is empty")
    #total is zero
    #empoty cart warning
  end

  xit 'can add an item' do
  end

  xit 'can remove an item' do
  end

  xit 'can update the quantity of an item' do
  end
end
