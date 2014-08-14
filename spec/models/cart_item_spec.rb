require 'rails_helper'

RSpec.describe CartItem, :type => :model do

  let(:cart_item) { create(:cart_item) }

  it 'Is not valid without a cart id' do
    cart_item.cart_id = nil
    expect(cart_item).to_not be_valid
  end

  it 'Is not valid without an item id' do
    cart_item.item_id = nil
    expect(cart_item).to_not be_valid
  end

end
