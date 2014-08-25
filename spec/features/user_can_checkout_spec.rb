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
  before do
    user = create :user
    order = create :order
    item = create :item

    visit login_path
    fill_in 'email address', :with => user.email
    fill_in 'password', :with => user.password
    click_button("Login")
    user.orders << order
    order.items << item
    visit order_path(order)
  end

  it 'can access the checkout page' do
    click_on('Proceed to Checkout')
    expect(page).to have_content("You're checking out!")
    expect(page).to have_content("Delivery")
  end
end
