require 'rails_helper'

RSpec.describe OrderItem, :type => :model do

  let(:order_item) { create(:order_item) }

  it 'Is not valid without a order id' do
    order_item.order_id = nil
    expect(order_item).to_not be_valid
  end

  it 'Is not valid without an item id' do
    order_item.item_id = nil
    expect(order_item).to_not be_valid
  end
end
