class ListingRequestsController < ApplicationController
  def index
    @listings_requests = current_user.items.flat_map { |listing| listing.order_items }
  end
end
