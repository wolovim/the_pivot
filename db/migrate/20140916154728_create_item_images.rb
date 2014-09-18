class CreateItemImages < ActiveRecord::Migration
  def change
    create_table :item_images do |t|
      t.references :item, index: true

      t.timestamps
    end
  end
end
