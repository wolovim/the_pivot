module OrdersHelper
  def order_item(item)
    item.order_items.where(order_id: @current_order.id).first
  end
end
