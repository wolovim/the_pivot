class AddAccommodationsToItems < ActiveRecord::Migration
  def change
    add_column :items, :accommodation, :string
  end
end
