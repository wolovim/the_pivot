class ChangeItemPriceFromFloatToInteger < ActiveRecord::Migration
  def change
    remove_column :items, :price, :float
    add_column :items, :price, :integer
  end
end
