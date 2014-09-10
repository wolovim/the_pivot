class CreateItemAvailabilities < ActiveRecord::Migration
  def change
    create_table :item_availabilities do |t|
      t.references :availability, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
