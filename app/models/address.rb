class Address < ActiveRecord::Base
  belongs_to :item

  geocoded_by :full_street_address
  after_validation :geocode
  validates :street_1, :city, :state, :zip, :item_id, presence: true

  private

  def full_street_address
    "#{street_1} #{city}, #{state} #{zip}"
  end

end
