class DenialsController < ApplicationController
  def create
    listing_request.update_attributes!(denied: true)
    redirect_to listing_requests_path
    send_denial_email
  end

  private

  def listing_requests
    current_user.order_items
  end

  def listing_request
    listing_requests.find(params[:listing_request_id])
  end

  def send_denial_email
    customer       = listing_request.order.user
    customer_email = customer.email

    Pony.mail(
      :from    => "TravelHomeBookings@gmail.com",
      :to      => customer_email,
      :subject => "Your Booking Request has been Denied",
      :body    => "Your request to book #{listing_request.item.title} has been denied. Please visit your dashboard to accept the change to your order."
    )
  end
end
