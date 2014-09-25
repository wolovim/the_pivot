require_relative 'feature_spec_helper'

describe "A user who is not logged in" do

  it "cannot access the checkout page" do
    order = create :order
    item = create :item
    order.items << item

    visit order_path(order)
    expect(page).to_not have_content('Proceed to Checkout')
  end

end

describe 'A user who is logged in' do
  include AdminHelper

  before do
    @user  = create(:user, email: "t@example.com")
    @host  = create(:user, email: "h@example.com")
    @order = create(:order, user_id: @user.id)
    @item  = create(:item,  user_id: @host.id)
    @user.orders << @order

    @order_item   = OrderItem.create(order_id: @order.id, item_id: @item.id)
    @availability = Availability.create(date: Time.now.to_date, order_item_id: @order_item.id)

    allow_any_instance_of(ApplicationController)
      .to receive(:order) { @order }

    log_me_in!
    visit order_path(@order)
  end

  it 'can access the checkout page' do
    click_on('Enter Payment Info')
    expect(page).to have_content("Enter Payment Info & Submit Booking Requests")
  end

  it 'can get to confirmation screen'  do
    click_on('Enter Payment Info')
    click_on('Everything good? Submit requests.')
    expect(page).to have_content('requested')
  end
end
