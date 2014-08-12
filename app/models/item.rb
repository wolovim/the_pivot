class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true
  
  has_many :categorizations
  has_many :categories, through: :categorizations
end
