class AddAttachmentImageToItemImages < ActiveRecord::Migration
  def self.up
    change_table :item_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :item_images, :image
  end
end
