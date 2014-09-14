class Availability < ActiveRecord::Base
	has_many :item_availabilities
	has_many :items, through: :item_availabilities

	validates :date, uniqueness: true
end