class CreateItemAddresses < ActiveRecord::Migration
  def change
    create_table :item_addresses do |t|
      t.references :item, index: true
      t.references :address, index: true

      t.timestamps
    end
  end
end
