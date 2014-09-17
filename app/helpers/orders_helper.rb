module OrdersHelper
  def order_item(item, item_order = order)
    item.order_items.where(order_id: item_order.id).first
  end

  def quantity_price(item, item_order)
    order_item(item, item_order).quantity * item.price
  end

  def quantity_price_for_humans(item, item_order = order)
    sprintf("%.2f", quantity_price(item, item_order)/100)
  end
end
