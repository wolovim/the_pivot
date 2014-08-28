class User < ActiveRecord::Base
  before_save { self.email == email.downcase }
  before_create :create_remember_token

  validates :first_name, presence: true
  validates :last_name, presence: true, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :username,
            allow_blank: true,
            length: {
              in: 2..32,
              too_short: 'Username is too short.',
              too_long: 'Username is too long.'
            }

  has_many :orders

  def full_name
    "#{first_name} #{last_name}"
  end

  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def name
    username || full_name
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
