require_relative 'feature_spec_helper'

describe 'the menu page', type: :feature do
  it 'shows a list of items' do
    item_1 = Item.create(title: 'food', description: 'delicious', price: 10.00)
    item_2 = Item.create(title: 'duck confils', description: 'expensive', price: 100.00)
    item_1.categories.create(name: "africa")
    item_2.categories.create(name: "asia")

    visit '/menu'
    expect(page).to have_content('food')
    expect(page).to have_content('expensive')
  end

  it 'views items by category' do
    item_1 = Item.create(title: 'food', description: 'delicious', price: 10.00)
    item_2 = Item.create(title: 'more food', description: 'delicious', price: 10.00)
    item_1.categories.create(name: "africa")
    item_2.categories.create(name: "asia")

    visit '/menu'
    page.click_on('africa')
    expect(current_path).to eq('/menu')
    expect(page).to have_content(item_1.title)
  end
end
