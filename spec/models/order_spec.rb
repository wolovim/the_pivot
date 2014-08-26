require 'rails_helper'

RSpec.describe Order, :type => :model do

  let(:order) { create(:order) }

  let(:address) do
    Address.new(order_id: 1, street_1: "123 Washington St", city: "Denver", state: "CO", zip: "80202")
  end

  it "belongs to one user" do
    user = User.new
    order.user_id = user.id
    expect(order.user_id).to eq(user.id)
  end

  it 'is valid' do
    expect(order).to be_valid
  end

  it 'is invalid without a delivery designation' do
    order.delivery = nil
    expect(order).to_not be_valid
  end

  it 'is valid with delivery designated as false' do
    order.delivery = false
    expect(order).to be_valid
  end

  it 'has address if delivery is true' do
    # address = Address.find_by_order_id(order.id)
    expect(order.delivery).to eq(true)
    expect(address.order_id).to eq(order.id)
  end

  xit 'has many items' do
    item_1 = build_item
    item_2 = build_item

    item_1.orders << order
    item_2.orders << order

    assert item_1.orders.include?(order)
    assert item_2.orders.include?(order)
  end

  it 'adds item to order' do
    item = build_item
    order.add_item(item)
    assert order.items.include? item
  end

  it 'removes item from order' do
    item = build_item
    order.add_item(item)
    order.remove_item(item)
    refute order.items.include? item
  end

  it 'increases quantity if item is in order' do
    item = build_item
    order.add_item(item)
    order.add_item(item)
    assert order.items.length == 1
  end

  def build_item
    create(:item)
  end
end
