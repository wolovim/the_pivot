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

  def destroy
    @order_item = OrderItem.find(params[:id])

    @order_item.destroy
    redirect_to orders_path
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

  def reminder
    send_host_reminder_email
    flash[:success] = "We've sent a friendly reminder to the host on your behalf!"
    redirect_to orders_path
  end

  def send_host_reminder_email
    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => "HostEmail@email.com",
      :subject => "You have Pending Requests",
      :body    => "Please visit your dashboard to take care of some pending booking requests."
    )
  end
end
