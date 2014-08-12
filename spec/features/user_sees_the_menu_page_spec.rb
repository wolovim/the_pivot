require_relative 'feature_spec_helper'

describe 'the menu page', type: :feature do
  it 'shows a list of items' do
    Item.create(title: 'food', description: 'delicious', price: 10.00)
    Item.create(title: 'duck confils', description: 'expensive', price: 100.00)

    visit '/menu'
    expect(page).to have_content('food')
    expect(page).to have_content('expensive')
  end
end