require_relative 'feature_spec_helper'

describe 'the menu page', type: :feature do
  it 'shows a list of items' do
    Item.create(title: 'food', description: 'delicious', price: 10.00)
    Item.create(title: 'duck confils', description: 'expensive', price: 100.00)

    visit '/menu'
    expect(page).to have_content('food')
    expect(page).to have_content('expensive')
  end

  it 'views items by category' do
    item1 = Item.create(title: 'food', description: 'delicious', price: 10.00)
    item2 = Item.create(title: 'more food', description: 'delicious', price: 10.00)
    item1.categories.create(name: "africa")
    item2.categories.create(name: "asia")

    visit '/menu'
    save_and_open_page
    page.click_on('africa')
    expect(current_path).to eq(category_path(item1))
    expect(page).to have_content(item1.title)
  end
end
