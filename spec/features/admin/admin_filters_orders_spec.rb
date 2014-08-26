require_relative '../feature_spec_helper'

describe "an admin filters orders by state" do
  before(:each) do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
    visit admin_orders_path
  end

  xit "sees all orders" do
    within ".orders-container" do
      Order.all.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
    end
  end

  xit "filters by basket" do
    within ".order-filters" do
      click_on("basket")
    end
    within ".orders-container" do
      Order.basket.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
      Order.all.reject {|order| order.basket?}.each do |order|
        expect(page).to_not have_content("Order #{order.id}")
      end
    end
  end

  xit "filters by ordered" do
    within ".order-filters" do
      click_on("ordered")
    end
    within ".orders-container" do
      Order.ordered.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
      Order.all.reject {|order| order.ordered?}.each do |order|
        expect(page).to_not have_content("Order #{order.id}")
      end
    end
  end

  xit "filters by paid" do
    within ".order-filters" do
      click_on("paid")
    end
    within ".orders-container" do
      Order.paid.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
      Order.all.reject {|order| order.paid?}.each do |order|
        expect(page).to_not have_content("Order #{order.id}")
      end
    end
  end

  xit "filters by complete" do
    within ".order-filters" do
      click_on("complete")
    end
    within ".orders-container" do
      Order.completed.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
      Order.all.reject {|order| order.completed?}.each do |order|
        expect(page).to_not have_content("Order #{order.id}")
      end
    end
  end

  xit "filters by cancelled" do
    within ".order-filters" do
      click_on("cancelled")
    end
    within ".orders-container" do
      Order.cancelled.each do |order|
        expect(page).to have_content("Order #{order.id}")
      end
      Order.all.reject {|order| order.cancelled?}.each do |order|
        expect(page).to_not have_content("Order #{order.id}")
      end
    end
  end
end
