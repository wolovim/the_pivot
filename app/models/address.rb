class Address < ActiveRecord::Base
  belongs_to :order

  validates :order_id, presence: true
  validates :street_1, :city, :state, :zip, presence: true

  def pickup?
    self.nil?
  end

  def delivery?
    !pickup?
  end
end
