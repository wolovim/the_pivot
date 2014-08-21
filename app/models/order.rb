class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  validates :delivery, presence: true

  def add_item(item)
    if self.items.include?(item)
      # binding.pry
      updated = self.order_items.where(item_id: item.id).first.quantity + 1
      self.order_items.where(item_id: item.id).first.update_attribute(:quantity, updated)
    else
      self.items << item
    end
  end

  def remove_item(item)
    self.items.delete(item)
  end
end
