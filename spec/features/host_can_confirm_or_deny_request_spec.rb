require_relative 'feature_spec_helper'

describe 'host', type: :feature do
  include SignInHelper

  before do
    @user = create(:user)
    sign_in(@user)
  end

  it "can see all booking requests" do
    my_futon     = create(:item, user: @user, title: "My Futon")
    order_1      = create(:order, user: @user)
    order_item_1 = OrderItem.create(order_id: order_1.id, item_id: my_futon.id)
    Availability.create(date: "20/10/2014", order_item_id: order_item_1.id)

    my_couch     = create(:item, user: @user, title: "My Couch")
    order_2      = create(:order, user: @user)
    order_item_2 = OrderItem.create(order_id: order_2.id, item_id: my_couch.id)
    Availability.create(date: "20/10/2014", order_item_id: order_item_2.id)

    my_bed = create(:item, user: @user, title: "My Bed")

    visit dashboard_user_path(@user)

    puts dashboard_user_path(@user)
    click_on "Manage Booking Requests for Your Listings"

    expect(page).to     have_content("My Futon")
    expect(page).to     have_content("My Couch")
    expect(page).not_to have_content("My Bed")
  end

  it "can confirm a request" do
    create_order_for_item(title: "My Futon")

    visit listing_requests_path
    click_on "Confirm"

    expect(page).to     have_content("CONFIRMED")
    expect(page).not_to have_content("Confirm Button")
  end

  it "can deny a request" do
    create_order_for_item(title: "My Futon")

    visit listing_requests_path
    click_on "Deny"

    expect(page).to     have_content("DENIED")
    expect(page).not_to have_content("Deny")
  end

  def create_order_for_item(title:)
    my_futon      = create(:item, user: @user)
    order_1       = create(:order, user: @user)
    order_item_1  = OrderItem.create(order_id: order_1.id, item_id: my_futon.id)
    Availability.create(date: "20/10/2014", order_item_id: order_item_1.id)
  end
end
