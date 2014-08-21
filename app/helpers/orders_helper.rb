module OrdersHelper
  def item_quantity(item)
    item.order_items.where(order_id: @current_order.id).first.quantity
  end
  

end
