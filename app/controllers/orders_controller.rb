class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
  end

  def edit
  end

  # def add_item
  #   binding.pry
  #   item = Item.find(params[:item_id])
  #   order.add_item(item)
  #   redirect_to order
  # end

  def update
    item = Item.find(params[:order][:item_id])
    requested_dates = parse_available_dates(params[:from], params[:to])
    order_item = OrderItem.create(item_id: item.id, 
                                  order_id: order.id, 
                                  quantity: requested_dates.count)

    requested_dates.each do |date|
      availability = item.availabilities.find_by(date: date)
      availability.order_item_id = order_item.id
      availability.save
    end

    redirect_to order
  end

  def parse_available_dates(start_date, end_date)
    start_date = Date.strptime(start_date, "%m/%d/%Y")
    end_date = Date.strptime(end_date, "%m/%d/%Y")
    date_range = (start_date..end_date).to_a
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

  def paid
    if order.ordered?
      order.pay!
    end
    session[:order_id] = nil
  end
end
