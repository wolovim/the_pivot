class User < ActiveRecord::Base
  # callback for email uniqueness
  before_save { self.email == email.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username,
            allow_blank: true,
            length: {
              in: 2..32,
              too_short: 'Username is too short.',
              too_long: 'Username is too long.'
            }

  has_many :orders
  has_one :cart
end
