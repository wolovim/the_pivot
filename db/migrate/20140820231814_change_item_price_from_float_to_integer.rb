class ChangeItemPriceFromFloatToInteger < ActiveRecord::Migration
  def change
    remove_column :items, :price, :integer
    add_column :items, :price, :float
  end
end
