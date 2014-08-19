class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :get_order
      
      t.timestamps
    end
  end
end
