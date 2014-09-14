class AddDateToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :date, :date
    add_column :availabilities, :user_id, :integer
  end
end
