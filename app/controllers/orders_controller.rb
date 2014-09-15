require 'pony'

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

  def paid
    if order.ordered?
      order.pay!
    end
    session[:order_id] = nil
  end

  def send_order
    Pony.mail(
      :from => "TravelHomeBookings@gmail.com",
      :to => "emilyadavis303@gmail.com",
      :subject => "Your Booking Summary",
      :body => "Test."
    )
  end
end
