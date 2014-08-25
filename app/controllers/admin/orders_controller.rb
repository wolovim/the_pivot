class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def completed
    @orders = Order.completed
  end

  def basket
    @orders = Order.basket
  end

  def paid
    @orders = Order.paid
  end

  def ordered
    @orders = Order.ordered
  end

  def cancelled
    @orders = Order.cancelled
  end

  def pay
    Order.find(params[:id]).paid!
    redirect_to admin_paid_orders_path
  end

  def complete
    Order.find(params[:id]).completed!
    redirect_to admin_completed_orders_path
  end

  def cancel
    Order.find(params[:id]).cancelled!
    redirect_to admin_orders_path
  end
end
