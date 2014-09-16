class Availability < ActiveRecord::Base
	has_many :item_availabilities
	has_many :items, through: :item_availabilities

	belongs_to :order_item
end