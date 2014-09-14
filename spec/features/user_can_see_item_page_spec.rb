require_relative 'feature_spec_helper'

describe 'an items show page', type: :feature do
  let(:item) { create :item, :title => "MyTitle"}

  it 'has a show page for an item' do
    visit item_path(item)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("MyTitle")
  end

  it 'has the number of people per unit' do
    visit item_path(item)
    expect(page).to have_content(1)
  end

  it 'has the price (or rate) of the unit' do
    visit item_path(item)
    expect(page).to have_content(32)
  end

  it 'has the bathroom indicator for the unit' do
    visit item_path(item)
    expect(page).to have_content("Private")
  end

  it "has an add to order button" do
    visit item_path(item)
    expect(page).to have_button('Book it!')
  end

  # For TravelHome, users should not be able to view an "extinct" item
  xit "can see an extinct item" do
    Item.extinction(item)
    visit item_path(item)
    expect(page).to_not have_button('Book it!')
  end

  it "cannot visit a page with no action" do
    visit "/dfghjk"
    expect(page).to have_content("scurry")
  end
end
