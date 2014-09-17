require_relative 'feature_spec_helper'

describe 'host', type: :feature do
  include SignInHelper

  it "can see all booking requests" do
    @user = create(:user)
    my_futon = create(:item, user: @user, title: "My Futon")
    my_couch = create(:item, user: @user, title: "My Couch")
    my_bed = create(:item, user: @user, title: "My Bed")
    create(:order, items: [my_futon])
    create(:order, items: [my_couch])

    sign_in(@user)

    visit dashboard_user_path(@user)
    puts dashboard_user_path(@user)
    click_on "Manage Booking Requests for Your Listings"

    expect(page).to have_content("My Futon")
    expect(page).to have_content("My Couch")
    expect(page).not_to have_content("My Bed")
  end
end
