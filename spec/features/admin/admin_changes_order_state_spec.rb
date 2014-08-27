require_relative '../feature_spec_helper'

describe "an admin changes order state" do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end

    it "changes one order from ordered to paid state" do
    order = create :order, aasm_state: "ordered"
    visit admin_orders_path(scope: 'ordered')

    within "h4.pull-left" do
      click_link_or_button 'Mark as Paid'
    end

    expect(current_url).to eq admin_orders_url(scope: 'paid')
    within ".order-display" do
      expect(page).to have_content order.created_at.to_formatted_s(:long_ordinal)
      expect(page).to have_content "Order ##{order.id}"
    end
  end

  it "changes one order from paid to completed state" do
    order = create :order, aasm_state: "paid"
    visit admin_orders_path(scope: 'paid')

    within "h4.pull-left" do
      click_link_or_button 'Mark as Completed'
    end

    expect(current_url).to eq admin_orders_url(scope: 'completed')
    within ".order-display" do
      expect(page).to have_content order.created_at.to_formatted_s(:long_ordinal)
      expect(page).to have_content "Order ##{order.id}"
    end
  end

  it "changes one order from ordered to cancelled state" do
    order = create :order, aasm_state: "ordered"
    visit admin_orders_path(scope: 'ordered')

    within "h4.pull-left" do
      click_link_or_button 'Cancel Order'
    end

    expect(current_url).to eq admin_orders_url(scope: 'cancelled')
    within ".order-display" do
      expect(page).to have_content order.created_at.to_formatted_s(:long_ordinal)
      expect(page).to have_content "Order ##{order.id}"
    end
  end

  it "changes one order from paid to cancelled state" do
    order = create :order, aasm_state: "paid"
    visit admin_orders_path(scope: 'paid')

    within "h4.pull-left" do
      click_link_or_button 'Cancel Order'
    end

    expect(current_url).to eq admin_orders_url(scope: 'cancelled')
    within ".order-display" do
      expect(page).to have_content order.created_at.to_formatted_s(:long_ordinal)
      expect(page).to have_content "Order ##{order.id}"
    end
  end
end
