class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :items, through: :cart_items
  belongs_to :user

  def add_item(item_id)
    cart_items.create(item_id: item_id, cart_id: self.id)
  end

end
