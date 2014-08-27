class Admin::OrdersController < AdminController
  def index
    filter = known_scopes.find(-> { :all }) { |scope_name| scope_name == params[:scope] }
    @orders = Order.public_send filter
  end

  def show
    @order = Order.find(params[:id])
  end

  def run_event
    @order = Order.find(params[:id])
    if @order.aasm.may_fire_event? params[:event].to_sym # <-- to_sym exposes gc hack :/
      @order.public_send "#{params[:event]}!" # <--  dynamic method invocation *sigh* fkn metaprogramming, y'all
    end
    redirect_to admin_orders_path(scope: @order.aasm_state)
  end

  private

  def known_scopes
    @known_scopes ||= Order.aasm.states.map { |state| state.name.to_s }
  end
end
