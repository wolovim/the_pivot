class ItemImage < ActiveRecord::Base
  belongs_to :item

  has_attached_file :image, :url => "https://s3.amazonaws.com/travelhome/:basename.:extension", :styles => { :small => "150x150#", :large => "300x300#" }
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/jpg', 'image/png','image/gif']
  validates_attachment_size :image, :less_than => 1.megabytes

  def json_image_link
  	self.image.url(:large)
  end

end
