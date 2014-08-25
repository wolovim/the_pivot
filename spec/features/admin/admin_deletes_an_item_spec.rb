require_relative '../feature_spec_helper'

describe 'admin', type: :feature do
  include AdminHelper

  before { login_as_admin }
  
  it 'deletes a menu item' do
    item = create :item, title: "MyTitle"
    item.categories.create(name: "Lunch")

    visit '/admin_dashboard'
    click_link 'View Menu Items'
    expect(page).to have_content "MyTitle"
    first(:link, "Delete Item").click

    expect(page).not_to have_content "MyTitle"
    expect(page).not_to have_content "Hello"
  end
end
