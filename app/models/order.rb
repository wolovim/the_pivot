class Order < ActiveRecord::Base
  belongs_to :user

  validates :get_order, presence: true
end
