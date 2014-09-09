class AddFieldsToItems < ActiveRecord::Migration
	
  def up
  	add_column :items, :people_per_unit, :integer, default: 1
  	add_column :items, :bathroom, :string, default: "private"
  end

  def down
		remove_column :items, :people_per_unit, :integer, default: 1
  	remove_column :items, :bathroom, :string, default: "private"
  end
end
