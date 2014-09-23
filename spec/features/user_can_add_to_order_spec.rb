require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  let(:current_order) { Order.create! }
  let(:user) { FactoryGirl.create :user }
  let(:item) { FactoryGirl.create :item, user_id: user.id }

  def book_an_item
    item.availabilities.create(date: "10/04/2014")
    item.availabilities.create(date: "11/04/2014")
    item.item_images.create!
    

    visit "/items"
    visit item_path(item)
    fill_in "from", with: "04/10/2014"
    fill_in "to", with: "04/11/2014"
    click_link_or_button "Book it!"
  end

  it "starts with zero items" do
    visit items_path
    visit order_path(current_order)

    expect(page).to have_content("You don't have any items in your cart!")
  end

  it "can add an item" do
    book_an_item

    expect(page).to have_css ".table", text: "MyTitle"
  end

  it "can remove an item" do
    book_an_item

    click_link_or_button "Remove"

    expect(page).not_to have_content("MyTitle")
    expect(page).not_to have_content("Remove")
  end

  it "reflects the correct number of nights" do
    book_an_item

    expect(page).to have_content "Nights"
    within(".nights") do
      expect(page).to have_content "1"
    end

  end

  it "displays the correct check-in and check-out dates" do
    book_an_item

    within(".check-in")  { expect(page).to have_content "Apr 10, 2014" }
    within(".check-out") { expect(page).to have_content "Apr 11, 2014" }
  end

  it "subtotals the price of each item in order" do
    book_an_item

    expect(page).to have_content('$0.32')
  end

  it "can return to an empty state" do
    book_an_item

    click_link_or_button("Remove")

    expect(page).to have_content("You don't have any items in your cart!")
  end
end
