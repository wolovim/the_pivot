require_relative 'feature_spec_helper'

describe 'host', type: :feature do
  include SignInHelper

  before do
    @user = create(:user)
    sign_in(@user)
  end

  it "can see all booking requests" do
    my_futon = create(:item, user: @user, title: "My Futon")
    my_couch = create(:item, user: @user, title: "My Couch")
    my_bed = create(:item, user: @user, title: "My Bed")
    create(:order, items: [my_futon])
    create(:order, items: [my_couch])

    visit dashboard_user_path(@user)
    puts dashboard_user_path(@user)
    click_on "Manage Booking Requests for Your Listings"

    expect(page).to have_content("My Futon")
    expect(page).to have_content("My Couch")
    expect(page).not_to have_content("My Bed")
  end

  it "can confirm a request",t:true do
    create_order_for_item(title: "My Futon")

    visit listing_requests_path
    click_on "Confirm Button"
    expect(page).to have_content("Listing Confirmed")
    expect(page).not_to have_content("Confirm Button")
  end

  def create_order_for_item(title:)
    item = create(:item, user: @user, title: title)
    create(:order, items: [item])
  end
end
