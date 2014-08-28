require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  include AdminHelper

  before { login_as_admin }

  it 'creates a new category' do
    item1 = create :item

    visit '/admin_dashboard'
    click_link "Create New Category"
    fill_in "Name", with: "Small Plates"
    click_button "Create Category"

    expect(current_url).to eq "http://www.example.com/admin/items"
    first(:link, "Add/Remove Categories").click
    expect(page).to have_content "Small Plates"
  end
end
