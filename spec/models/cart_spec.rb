require 'rails_helper'

RSpec.describe Cart, :type => :model do
  let(:cart) { Cart.new }
  it 'is valid' do
    expect(cart).to be_valid
  end

  it 'has an array of items' do
    expect(cart.items).to eq([])
  end

  it 'belongs to a user' do
    expect(cart).to respond_to(:user)
  end
end
