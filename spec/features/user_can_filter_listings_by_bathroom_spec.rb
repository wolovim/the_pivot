require_relative 'feature_spec_helper'

describe 'user', type: :feature do
  it 'gets json back' do
    visit items_path(format: :json)
    json_response = JSON.parse(page.body, symbolize_names: true)
    expect(json_response).to have_content []
  end

  it 'gets back items' do
    items = create_list :item, 3
    visit items_path(format: :json)
    json_response = JSON.parse(page.body, symbolize_names: true)
    expect(json_response).to eq items.map { |item| JSON.parse(ItemSerializer.new(item, {root: false}).to_json, symbolize_names: true) }
  end

  xit 'can see bathroom filter options' do
    visit items_path(format: :json)
    # expect(page).to have_button 'Private'
    expect(page).to have_css(".button", text: "Shared")
  end

  it 'can filter results by "private" bathroom' do
    item1          = create :item
    item1.title    = "Listing 1"
    item1.bathroom = "Private"
    item1.save

    item2          = create :item
    item2.title    = "Listing 2"
    item2.bathroom = "Shared"
    item2.save

    visit items_path
    visit current_path
    within(".btn-group.bathrooms") { click_button "Private" }
    expect(page).to_not have_content('Listing 2')

  end
end
