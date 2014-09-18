class AddDeniedToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :denied, :boolean, null: false, default: false
  end
end
