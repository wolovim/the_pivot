class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  validates :delivery, presence: true

  def add_item(item)
    if self.items.include?(item)
      access_order_item(item).increment!(:quantity)
    else
      self.items << item
    end
  end

  def remove_item(item)
    self.items.delete(item)
  end

  def access_order_item(item)
    self.order_items.where(item_id: item.id).first
  end

  def empty?
    items.empty?
  end

  def total
    order_items.reduce(0) do |sum, order_item|
      sum += order_item.quantity * order_item.item.price
    end
  end
end
