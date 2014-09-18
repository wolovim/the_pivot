class AddPathToItems < ActiveRecord::Migration
  def change
    add_column :items, :path, :string
  end
end
