class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
  end

  def edit
  end

  def update
    item            = Item.find(params[:order][:item_id])
    requested_dates = parse_available_dates(params[:from], params[:to])
    order_item      = OrderItem.create(item_id: item.id,
                                      order_id: order.id,
                                      quantity: requested_dates.count)
    make_dates_unavailable(item, order_item, requested_dates)
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

  def checkout
    @address = Address.create
  end

  def confirm
    if order.basket?
      order.order!
    end
  end

  def requested
    if order.ordered?
      order.update_attribute(:user_id, current_user.id)
      order.request!
      send_order_emails
    end
    session[:order_id] = nil
  end

  def completed
    user_order = current_user.orders.find(params[:id])

    if user_order.may_complete? && user_order.order_items.all? {|oi| oi.confirmed? || oi.denied?}
      user_order.complete!
    end

    flash[:success] = "Your booking has been completed, and your credit card has been charged."
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit()
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

  def parse_available_dates(start_date, end_date)
    start_date = Date.strptime(start_date, "%m/%d/%Y")
    end_date = Date.strptime(end_date, "%m/%d/%Y")
    date_range = (start_date..end_date).to_a
    date_range.first(date_range.size - 1)
  end

  def make_dates_unavailable(item, order_item, requested_dates)
    requested_dates.each do |date|
      availability = item.availabilities.find_by(date: date)
      availability.order_item_id = order_item.id
      availability.save
    end
  end

  def send_customer_email
    customer_email = order.user.email

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => customer_email,
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
