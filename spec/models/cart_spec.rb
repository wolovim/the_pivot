require 'rails_helper'

RSpec.describe Cart, :type => :model do
  let(:cart) { Cart.new }
  let(:item) { build(:item) }

  it 'is valid' do
    expect(cart).to be_valid
  end

  it 'has an array of items' do
    expect(cart.items).to eq([])
  end

  it 'belongs to a user' do
    expect(cart).to respond_to(:user)
  end

  it 'can add an item to a cart' do
    binding.pry
    # cart.save
    # expect(cart.items.size).to eq(0)
    # cart.add_item(title: 'tiger', description: 'bengal tiger served on bed of rice', price: 35.00)
    # expect(cart.items.size).to eq(1)
  end
end
