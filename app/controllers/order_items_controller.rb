class OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])

    if quantity_params != '0'
      @order_item.update_attribute(:quantity, quantity_params)
      redirect_to order
    else
      @order_item.destroy
      redirect_to order
    end
  end

  def quantity_params
    result = @order_item.quantity_update(params[:item][:quantity])

    if result != nil
      result
    else
      flash[:toomany] = "There aren't enough of that animal left!"
      params[:item][:quantity] = 1
    end
  end

  def send_host_reminder_email
    host_email = item.user.email

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => host_email,
      :subject => "You have Pending Requests",
      :body    => "Hi #{item.user.first_name}, don't forget to visit your dashboard to confirm or deny #{order.user.first_name}'s request!"
    )
  end
end
