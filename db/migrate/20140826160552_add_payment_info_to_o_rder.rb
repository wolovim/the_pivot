class AddPaymentInfoToORder < ActiveRecord::Migration
  def change
    add_column :orders, :ccn, :string
    add_column :orders, :expdate, :string
    add_column :orders, :card_name, :string
  end
end
