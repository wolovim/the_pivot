class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  validates :order_id, :item_id, presence: true
  before_create :set_default_quantity

  def quantity_update(params)
    if params.to_i >= 0
      quantity_limit(params)
    else
      1
    end
  end

  def quantity_limit(params)
    if params.to_i <= item.max_quantity
      params
    else
      nil
    end
  end

  private

  def set_default_quantity
    quantity = 1
  end
end
