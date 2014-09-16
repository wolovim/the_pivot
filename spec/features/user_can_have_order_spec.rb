require_relative 'feature_spec_helper'

describe 'an order', type: :feature do
  let(:current_order) { Order.create! }
  let(:item) { create :item }

  it 'starts with zero items' do
    visit items_path
    visit order_path(current_order)

    expect(page).to have_content("You don't have any items in your cart!")
  end

  xit 'can add an item' do
    item = create :item, title: "John"
    item.categories.create(name: 'Appetizers')

    visit items_path
    click_button("Book it!")
    visit order_path(current_order)

    expect(page).to have_content("John")
  end

  xit 'can remove an item' do
    item = create :item, title: "John"

    visit item_path(item)
    click_button("Book it!")
    visit order_path(current_order)
    click_button("Remove")

    expect(page).not_to have_content("John")
    expect(page).not_to have_content("Remove")
  end

  xit 'can change an item quantity from the order page' do
    visit item_path(item)

    click_button("Book it!")
    visit order_path(current_order)

    expect(page).to have_content("Quantity")

    fill_in('item[quantity]', with: 200)
    click_on('Update')

    expect(page).to have_selector("input[value='200']")
  end

  xit 'increases quantity when adding repeat items to the order' do
    visit item_path(item)

    click_button("Book it!")
    visit item_path(item)
    click_button("Book it!")

    expect(page).to have_selector("input[value='2']")
  end

  xit 'cannot have a negative quantity' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100)
    visit item_path(item)
    click_button("Book it!")
    fill_in('item[quantity]', with: -2)
    click_on('Update')
    expect(page).to have_selector("input[value='1']")
  end

  xit 'cannot exceed max quantity' do
    item = Item.create!(title: 'John', description: 'Doe', price: 100)
    visit item_path(item)
    click_button("Book it!")
    fill_in('item[quantity]', with: 6000)
    click_on('Update')
    expect(page).to have_content("There aren't enough of that animal left!")
  end

  xit 'subtotals the price of each item in order' do
    item = create :item, price: 100

    visit item_path(item)
    click_button("Book it!")
    visit item_path(item)
    click_button("Book it!")

    expect(page).to have_content('$2.00')
  end

  xit 'totals the price of all items in order' do
    item1 = create :item, title: "John", price: 100
    item2 = create :item, title: "Jane", price: 50
    item1.categories.create(name: 'Appetizers')
    item2.categories.create(name: 'Appetizers')

    visit items_path

    page.find(:xpath, "(//div[@class='caption'])[1]").click_on("Book it!")

    visit items_path
    page.find(:xpath, "(//div[@class='caption'])[2]").click_on("Book it!")

    expect(page).to have_content('$1.50')
  end
end
