class ChangeNameFromCartToOrder < ActiveRecord::Migration
  def change
    drop_table :carts
    rename_table :cart_items, :order_items
    rename_column :order_items, :cart_id, :order_id
    rename_column :orders, :get_order, :delivery
    change_column :orders, :delivery, 'boolean USING CAST(delivery AS boolean)'


  end
end
