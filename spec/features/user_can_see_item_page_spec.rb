require_relative 'feature_spec_helper'

describe 'an items show page', type: :feature do
  let(:item) { create :item, :title => "MyTitle"}

  before do
    item.item_images.create!
    item.availabilities.create!(date: "20/12/2014", date: "20/12/2014")
    visit '/menu'
  end

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

  it "has an 'Book it!' button" do
    visit item_path(item)
    expect(page).to have_button('Book it!')
  end

  it "cannot visit a page with no action" do
    visit "/dfghjk"
    expect(page).to have_content("scurry")
  end
end
