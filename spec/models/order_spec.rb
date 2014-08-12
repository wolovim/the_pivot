require 'rails_helper'

RSpec.describe Order, :type => :model do

  let(:order) do
    Order.new(id: 1, user_id: 1, get_order: "delivery")
  end

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

  it 'is invalid without a get_order designation' do
    order.get_order = nil
    expect(order).to_not be_valid
  end

  it 'has address if get_order is "delivery"' do
    # address = Address.find_by_order_id(order.id)
    expect(order.get_order).to eq("delivery")
    expect(address.order_id).to eq(order.id)
  end

end
