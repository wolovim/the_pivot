require_relative '../feature_spec_helper'

describe "an admin changes order state" do
  before(:each) do
    create :order, aasm_state: "ordered"
    visit admin_ordered_orders_path
  end

  it "changes one order from ordered to paid state" do
    within ".change-order-state" do
      first(:link, "Mark as Paid").click
    end
    within ".order-status" do
      save_and_open_page
      expect(page).to have_content("paid")
      expect(page).not_to have_content("ordered")
    end
  end
end
