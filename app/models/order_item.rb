class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item
  has_many   :availabilities

  validates  :order_id, :item_id, presence: true

  before_create :set_default_quantity

  def quantity_update(params)
    if params.to_i >= 0
      quantity_limit(params)
    else
      1
    end
  end

  def quantity_limit(params)
    if params.to_i <= item.max_quantity
      params
    else
      nil
    end
  end

  def send_host_email
    host_email = item.user.email
    host_name  = item.user.first_name

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => host_email,
      :subject => "You have received a booking request!",
      :body    => "Hi #{host_name}, you have a booking request for #{item.title}. Please visit your dashboard to accept or deny the request."
    )
  end

  def checkin_date
    self.availabilities.first.date.strftime("%b %d, %Y")
  end

  def checkout_date
    last_night = self.availabilities.last.date
    checkout = last_night + 1
    checkout.strftime("%b %d, %Y")
  end

  def send_host_reminder_email
    host_email = item.user.email

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => host_email,
      :subject => "You have Pending Requests",
      :body    => "Hi #{item.user}, don't forget to confirm or deny #{order.user.first_name}'s request!"
    )
  end

  private

  def set_default_quantity
    quantity = 1
  end
end
