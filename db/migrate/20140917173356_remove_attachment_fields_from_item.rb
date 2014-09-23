class RemoveAttachmentFieldsFromItem < ActiveRecord::Migration
  def change
    remove_attachment :items, :image
  end
end
