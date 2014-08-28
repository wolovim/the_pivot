class Admin::OrderItemsController < AdminController
  def update
    @order_item = OrderItem.find(params[:id])

    if @order_item.update_attribute(:quantity, quantity_params)
      redirect_to admin_order_path(@order_item.order_id)
    else
      render :edit
    end
  end

  def quantity_params
    result = @order_item.quantity_update(params[:item][:quantity])

    if result != nil
      result
    else
      flash[:toomany] = "There aren't enough of that animal left!"
      params[:item][:quantity] = 0
    end
  end
end