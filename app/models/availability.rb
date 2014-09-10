class Availability < ActiveRecord::Base
	has_many :item_availabilities
	has_many :items, through: :item_availabilities

	validates :start_date, presence: true
	validates :end_date, presence: true
end