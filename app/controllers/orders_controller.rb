class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
  end

  def edit
  end

  def add_item
    item = Item.find(params[:item_id])
    order.add_item(item)
    redirect_to order
  end

  def delete_item
    item = Item.find(params[:item_id])
    order.remove_item(item)
    redirect_to order
  end

  def destroy
    order.destroy
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit()
  end

  def checkout
    @address = Address.create
  end

  def confirm
    if order.basket?
      order.order!
    end

    # @address = Address.create()
  end

  def requested
    if order.ordered?
      order.update_attribute(:user_id, current_user.id)
      order.request!
      send_order_emails
    end
    session[:order_id] = nil
  end

  def paid
    if order.requested?
      order.pay!
    end
  end

  def send_order_emails
    send_customer_email
    send_host_emails
  end

  private

  def send_customer_email
    customer_email = order.user.email

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => "#{customer_email}",
      :subject => "Your Booking Summary",
      :body    => "Thank you for planning your trip with TravelHome! We've notified the hosts of your booking requests! \n
                  Order Number: #{order.id}\n
                  Number of Requests: #{order.order_items.count}"
    )
  end

  def send_host_emails
    order.order_items.each(&:send_host_email)
  end
end
