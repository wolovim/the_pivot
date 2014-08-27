class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :categorizations
  has_many :items, through: :categorizations

  scope :main_categories, -> {  where(name: %w(Breakfast Appetizers Lunch Dinner)) }
  scope :special_categories, -> { where.not(name: %w(Breakfast Appetizers Lunch Dinner)) }
end
