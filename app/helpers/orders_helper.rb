module OrdersHelper
  def order_item(item)
    item.order_items.where(order_id: order.id).first
  end

  def quantity_price(item)
    order_item(item).quantity * item.price
  end

  def quantity_price_for_humans(item)
    sprintf("%.2f", quantity_price(item)/100)
  end
end
