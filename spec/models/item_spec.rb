require 'rails_helper'

RSpec.describe Item, :type => :model do
  let(:valid_params) { {title:'item', description: 'items items', price: 10.01} }

  describe "with valid params" do
    it 'is valid' do
      item = Item.create valid_params
      expect(item).to be_valid
    end

    it 'has a unique name' do
      item = Item.create valid_params
      expect(item).to be_valid
      item2 = Item.create valid_params
      expect(item2).to_not be_valid
    end

    it 'has categories' do
      item = Item.create valid_params
      expect(item.categories).to eq([])
    end

    it 'has an order' do
      item = Item.create valid_params
      expect(item).to respond_to(:orders)
    end
  end

  describe "without valid params" do
    it 'is not valid without name' do
      item = Item.create valid_params
      item.title = nil
      expect(item).to_not be_valid
    end

    it 'is not valid without description' do
      item = Item.create valid_params
      item.description = nil
      expect(item).to_not be_valid
    end

    it 'is not valid without price' do
      item = Item.create valid_params
      item.price = nil
      expect(item).to_not be_valid
    end

    it 'has many orders' do
      item = Item.create!(valid_params)
      order1 = Order.create(delivery: true)
      order2 = Order.create(delivery: true)

      order1.items << item
      order2.items << item

      assert order1.items.include?(item)
      assert order2.items.include?(item)
    end
  end
end
