class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  validates :delivery, presence: true

  def add_item(item)
    self.items << item
  end

  def remove_item(item)
    self.items.delete(item)
  end
end
