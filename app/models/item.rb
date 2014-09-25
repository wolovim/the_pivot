class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates_inclusion_of :bathroom, in: ["Private", "Shared"]

  belongs_to :user

  has_many  :item_images, :dependent => :destroy

  has_one :address, dependent: :destroy

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
    unless start_date == "" && end_date == ""
      start_date = Date.strptime(start_date, "%m/%d/%Y")
      end_date = Date.strptime(end_date, "%m/%d/%Y")
      date_range = (start_date..end_date).to_a

      date_range.map { |date| {date: date} }
    end
  end

  def available_from_dates
    self.availabilities.unreserved.map { |a| a.date.strftime("%Y-%m-%d") }
  end

  def available_to_dates
    self.availabilities.unreserved.map do |avail|
      available_date = avail.date
      (available_date + 1).strftime("%Y-%m-%d")
    end
  end

  def accommodation
    categories.first.name if categories.any?
  end
end
