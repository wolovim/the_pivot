class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  has_many  :item_images, :dependent => :destroy
  
  accepts_nested_attributes_for :item_images

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

  def parse_available_dates(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    date_range = (start_date..end_date).to_a

    date_range.map { |date| {date: date} }
  end

  def accommodation
    categories.first.name if categories.any?
  end
end
