class Admin::OrdersController < AdminController
  def index
    filter = known_scopes.find(-> { :all }) { |scope_name| scope_name == params[:scope] }
    @orders = Order.public_send filter
  end

  def by_scope
  end

  def show
    @order = Order.find(params[:id])
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
    redirect_to admin_cancelled_orders_path
  end

  private

  def known_scopes
    @known_scopes ||= Order.aasm.states.map { |state| state.name.to_s }
  end
end
