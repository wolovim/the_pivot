class AddMaxQuantityToItem < ActiveRecord::Migration
  def change
    add_column :items, :max_quantity, :integer, :default => 500
  end
end
