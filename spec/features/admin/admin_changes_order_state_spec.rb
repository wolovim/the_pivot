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
    create :order, aasm_state: "ordered"
    visit admin_ordered_orders_path
    within ".change-order-state" do
      first(:link, "Mark as Paid").click
    end
      expect(page).not_to have_content("Mark as Paid")

  end

  it "changes one order from paid to completed state" do
    create :order, aasm_state: "paid"
    visit admin_paid_orders_path
    within ".change-order-state" do
      first(:link, "Mark as Completed").click
    end
      expect(page).not_to have_content("Mark as Completed")
  end

  it "changes one order from ordered to cancelled state" do
    create :order, aasm_state: "ordered"
    visit admin_ordered_orders_path
    within ".change-order-state" do
      first(:link, "Cancel Order").click
    end
      expect(page).not_to have_content("Cancel Order")
  end

  it "changes one order from paid to cancelled state" do
    create :order, aasm_state: "paid"
    visit admin_paid_orders_path
    within ".change-order-state" do
      first(:link, "Cancel Order").click
    end
      expect(page).not_to have_content("Cancel Order")
  end
end
