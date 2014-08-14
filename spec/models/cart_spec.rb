require 'rails_helper'

RSpec.describe Cart, :type => :model do
  let(:cart) { create(:cart) }
  let(:item) { create(:item) }
  let(:item2) { create(:item, title: 'Some cool name') }

  it 'is valid' do
    expect(cart).to be_valid
  end

  it 'has an array of items' do
    expect(cart.cart_items).to eq([])
  end

  it 'belongs to a user' do
    expect(cart).to respond_to(:user)
  end

  it 'can add an item to a cart' do
    cart.add_item(item.id)
    cart_item = cart.cart_items.first
    expect(cart_item.item_id).to eq item.id
  end

  it 'can retrieve a list of items in the cart' do
    cart.add_item(item.id)
    expect(cart.items.first).to eq item
  end

  # context 'Given that the cart only has 1 item' do
  #   it 'can add up item totals' do
  #     cart.items << item
  #     cart.items << item2
  #     expect(cart.total).to eq(item.price + item2.price)
  #   end
  # end
end
