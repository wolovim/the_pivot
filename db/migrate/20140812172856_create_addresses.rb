class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :order, index: true
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
