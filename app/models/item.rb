class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  validates :price, presence: true, numericality: { greater_than: 0 }
  has_attached_file :image, :styles => { :medium => "200x200%", :thumb => "20x20>" }, :default_url => "/assets/:style/missing.jpg"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png','image/gif']
  validates_attachment_size :image, :less_than => 1.megabytes

  validates :price, presence: true

  belongs_to :user

  has_one :address

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :item_availabilities
  has_many :availabilities, through: :item_availabilities

  has_many :order_items
  has_many :orders, through: :order_items

  scope :endangered, -> { where(scarcity: endangered) }
  scope :extinct,    -> { where(scarcity: extinct) }

  def add_category(category)
    if !self.categories.include?(category)
      self.categories << category
    end
  end

  def price_for_humans
    sprintf("%.2f", (price.to_f/100))
  end

  def remove_category(category)
    self.categories.delete(category)
  end

  def self.extinction(item)
    item.scarcity = 'extinct'
    item.save
  end

  def extinct?
    self.scarcity == 'extinct'
  end
end
