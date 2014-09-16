class Availability < ActiveRecord::Base
	has_many :item_availabilities
	has_many :items, through: :item_availabilities

	belongs_to :order_item

	scope :unreserved, -> { where(order_item_id: nil) }
end