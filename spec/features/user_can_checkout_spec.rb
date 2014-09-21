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
    @host  = create(:user, id: 999, email: "h@example.com")
    @order = create :order
    @item  = create(:item, user_id: 999)
    @user.orders << @order
    @order.items << @item
    allow_any_instance_of(ApplicationController)
      .to receive(:order) { @order }

    log_me_in!
    visit order_path(@order)
  end

  it 'can access the checkout page' do
    click_on('Proceed to Booking Summary')
    expect(page).to have_content("Confirm Booking Requests")
  end

  it 'can get to confirmation screen'  do
    click_on('Proceed to Booking Summary')
    click_on('Look Good? Send booking requests.')
    expect(page).to have_content('requested')
  end

  it 'can add addresses' do
    skip
    click_on('Proceed to Checkout')
    fill_in 'address[street_1]', with: '123 Main St.'
    fill_in 'address[city]', with: 'Denver'
    fill_in 'address[state]', with: 'CO'
    fill_in 'address[zip]', with: 123456
    click_on('Save Address')
    expect(page).to have_content('123 Main St.')
  end

  it 'can add payment info' do
    skip
    click_on('Proceed to Checkout')
    fill_in 'order[ccn]', with: '1234567812345678'
    fill_in 'order[expdate]', with: '12-12'
    fill_in 'order[card_name]', with: 'Allison Larson'
    click_on('Continue to Confirmation Screen')
    expect(page).to have_content('Confirm Order')
  end
end
