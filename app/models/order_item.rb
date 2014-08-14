class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates :order_id, :item_id, presence: true
end
