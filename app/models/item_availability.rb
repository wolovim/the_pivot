class ItemAvailability < ActiveRecord::Base
	belongs_to :availability
	belongs_to :item
end