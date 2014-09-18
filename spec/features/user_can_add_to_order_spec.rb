require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  let(:current_order) { Order.create! }
  let(:item) { create :item }

  def book_an_item
    item.availabilities.create(date: "10/04/2014")
    item.availabilities.create(date: "11/04/2014")
    item.item_images.create!

    visit '/items' 
    visit item_path(item)
    fill_in "from", with: "04/10/2014"
    fill_in "to", with: "04/11/2014"
    click_link_or_button "Book it!"
  end

  it 'starts with zero items' do
    visit items_path
    visit order_path(current_order)

    expect(page).to have_content("You don't have any items in your cart!")
  end

  it 'can add an item' do
    book_an_item

    expect(page).to have_css ".table", text: "MyTitle"
  end

  it 'can remove an item' do
    book_an_item

    click_link_or_button "Remove"

    expect(page).not_to have_content("MyTitle")
    expect(page).not_to have_content("Remove")
  end

  xit 'reflects the correct number of nights' do
    book_an_item

    expect(page).to have_content "Nights"
  end

  xit 'increases quantity when adding repeat items to the order' do
    visit item_path(item)

    click_link_or_button("Book it!")
    visit item_path(item)
    click_link_or_button("Book it!")

    expect(page).to have_selector("input[value='2']")
  end

  xit 'cannot have a negative quantity' do
    visit item_path(item)
    click_link_or_button("Book it!")
    fill_in('item[quantity]', with: -2)
    click_on('Update')
    expect(page).to have_selector("input[value='1']")
  end

  xit 'cannot exceed max quantity' do
    visit item_path(item)
    click_link_or_button("Book it!")
    fill_in('item[quantity]', with: 6000)
    click_on('Update')
    expect(page).to have_content("There aren't enough of that animal left!")
  end

  it 'subtotals the price of each item in order' do
    book_an_item

    expect(page).to have_content('$0.64')
  end

  it "can return to an empty state" do
    book_an_item
    
    click_link_or_button("Remove")

    expect(page).to have_content("You don't have any items in your cart!")
  end
end
