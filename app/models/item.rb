class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :order_items
  has_many :orders, through: :order_items

  scope :endangered, -> { where(scarcity: endangered) }
  scope :extinct,    -> { where(scarcity: extinct) }

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

  def set_default_scarcity
    scarcity = 'endangered'
  end

  def self.extinction(item)
    item.scarcity = 'extinct'
    item.save
  end
end
