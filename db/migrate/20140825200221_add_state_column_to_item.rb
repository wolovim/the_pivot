class AddStateColumnToItem < ActiveRecord::Migration
  def change
    add_column :items, :scarcity, :string, default: "endangered"
  end
end
