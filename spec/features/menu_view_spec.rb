require_relative 'feature_spec_helper'

describe 'the menu view', type: :feature do
  it 'shows a list of items' do
    item_1 = create :item, :title => "food"
    item_2 = create :item, :description => "expensive"

    # Items currently displayed by category, so no category = no items :o
    item_1.categories.create(name: "africa")
    item_2.categories.create(name: "asia")

    visit '/menu'
    expect(page).to have_content('food')
    expect(page).to have_content('expensive')
  end

  it 'views items by category' do
    item_1 = create :item, :title => "MyTitle"
    item_2 = create :item
    item_1.categories.create(name: "africa")
    item_2.categories.create(name: "asia")

    visit '/menu'
    page.click_on('africa')
    expect(current_path).to eq('/menu')
    expect(page).to have_content("MyTitle")
  end
end
