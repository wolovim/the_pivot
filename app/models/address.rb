class Address < ActiveRecord::Base
  belongs_to :item

  validates :street_1, :city, :state, :zip, :item_id, presence: true
end
