class User < ActiveRecord::Base
  before_save { self.email == email.downcase }
  before_create :create_remember_token

  validates :first_name,  presence: true
  validates :last_name,   presence: true, allow_blank: true
  validates :email,       presence: true, uniqueness: { case_sensitive: false }
  validates :password,    presence: true, length: { minimum: 8 }
  validates :username,    allow_blank: true,
                          length: {
                            in: 2..32,
                            too_short: 'Username is too short.',
                            too_long: 'Username is too long.'
                          }

  has_many :orders
  has_many :items
  has_many :order_items, through: :items

  has_attached_file :avatar, styles: { :medium => "300x300#", :thumb => "100x100#" }, default_url: "/assets/medium/awesome.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

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

  def default_url
    "/assets/avatars"
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
