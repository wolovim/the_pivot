class ListingRequestsController < ApplicationController
  def index
    @listings_requests = current_user.order_items
  end
end
