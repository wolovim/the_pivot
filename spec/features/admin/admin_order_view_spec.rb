require_relative '../feature_spec_helper'

describe 'admin order/show', type: :feature do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end

  before do
    user = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "swordfish")
    # we need user/order/item/orderitem
    item1 = Item.create!(title: "Food", description: "Yum", price: 20.00)
    item2 = Item.create!(title: "MoarFood", description: "Yummer", price: 20.00)
    order1 = Order.create!(user_id: user.id, delivery: true)
    order2 = Order.create!(user_id: user.id, delivery: true)
    OrderItem.create!(item_id: item1.id, order_id: order1.id)
    OrderItem.create!(item_id: item2.id, order_id: order2.id)
  end

  xit 'shows the total number of orders' do
    expect(page).to have_css ".order-title", text: "Order 2"
  end
end
