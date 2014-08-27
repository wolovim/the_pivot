module OrdersHelper
  def order_item(item)
    item.order_items.where(order_id: order.id).first
  end
end
