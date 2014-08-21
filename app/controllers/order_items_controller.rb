class OrderItemsController < ApplicationController
  def update
    @orderitem = OrderItem.find(params[:id])


      if @orderitem.update_attribute(:quantity, params[:item][:quantity])
      redirect_to current_order
    else
      render :edit
    end

  end
end
