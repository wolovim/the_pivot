class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "20x20>" }, :default_url => "/assets/:style/missing.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  before_create :set_default_max_quantity

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :order_items
  has_many :orders, through: :order_items

  def add_category(category)
    if !self.categories.include?(category)
      self.categories << category
    end
  end

  def remove_category(category)
    self.categories.delete(category)
  end

  def set_default_max_quantity
    max_quantity = 500
  end
end
