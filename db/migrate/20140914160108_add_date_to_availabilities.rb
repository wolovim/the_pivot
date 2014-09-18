class AddDateToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :date, :date
    add_column :availabilities, :order_item_id, :integer
  end
end
