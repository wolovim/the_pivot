class ItemImage < ActiveRecord::Base
  belongs_to :item

  has_attached_file :item, :styles => { :small => "150x150>", :large => "320x240>" }
  validates_attachment_presence :item
  validates_attachment_size :item, :less_than => 5.megabytes
end
