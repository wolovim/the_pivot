class AddConfirmedToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :confirmed, :boolean, null: false, default: false
  end
end
