require_relative '../feature_spec_helper'

describe 'the admin orders view', type: :feature do

  it 'displays a list of orders' do
    # not sure if I need these
    user1 = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "swordfish")
    user2 = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@example.com", password: "swordfish")

    order1 = Order.create!(user_id: user1.id, delivery: true)
    item1 = Item.create!(title: "Food", description: "Yum", price: 20)
    order1.order_items.create!(item_id: item1.id)

    order2 = Order.create!(user_id: user2.id, delivery: true)
    item2 = Item.create!(title: "MoarFood", description: "Yummer", price: 20)
    order2.order_items.create!(item_id: item2.id)

    visit admin_orders_path
    expect(page).to have_css '.order-display'
  end

  it 'can display total orders by status' do
    user1 = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "swordfish")
    user2 = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@example.com", password: "swordfish")

    order1 = Order.create!(user_id: user1.id, delivery: true)
    item1 = Item.create!(title: "Food", description: "Yum", price: 20)
    order1.order_items.create!(item_id: item1.id)

    order2 = Order.create!(user_id: user2.id, delivery: true, aasm_state: "paid")
    item2 = Item.create!(title: "MoarFood", description: "Yummer", price: 20)
    order2.order_items.create!(item_id: item2.id)

    visit admin_orders_path
    expect(page).to have_content("paid: 1")
    expect(page).to have_content("basket: 1")
  end

end
