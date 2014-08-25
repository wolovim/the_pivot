class OrderItemsController < ApplicationController
  def update
    @orderitem = OrderItem.find(params[:id])

    if @orderitem.update_attribute(:quantity, quantity_params)
      redirect_to current_order
    else
      render :edit
    end
  end

  def quantity_params
    result = @orderitem.quantity_update(params[:item][:quantity])

    if result != nil
      result
    else
      flash[:toomany] = "There aren't enough of that animal left!"
      params[:item][:quantity] = 0
    end
  end

end
