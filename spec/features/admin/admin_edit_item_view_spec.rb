require_relative '../feature_spec_helper'

describe 'the admin edit item view', type: :feature do

  it 'displays the correct item information in the form' do
    item = Item.create(title: "Food", description: "Yumasdf", price: 10.00)
    visit edit_admin_item_path(item)
    expect(page.status_code).to eq 200
  end

end