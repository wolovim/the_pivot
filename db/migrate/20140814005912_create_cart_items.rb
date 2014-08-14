class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end
