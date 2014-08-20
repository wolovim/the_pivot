class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates :order_id, :item_id, presence: true
  before_create :set_default_quantity

  def set_default_quantity
    quantity = 1
  end


end
