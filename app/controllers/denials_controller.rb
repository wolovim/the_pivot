class DenialsController < ApplicationController
  def create
    listing_request.update_attributes!(denied: true)
    redirect_to listing_requests_path
  end

  private

  def listing_requests
    current_user.order_items
  end

  def listing_request
    listing_requests.find(params[:listing_request_id])
  end
end
