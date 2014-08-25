require_relative '../feature_spec_helper'

describe 'the admin dashboard', type: :feature do
  include AdminHelper

  before { login_as_admin }
  
  it 'has links' do
    visit '/admin_dashboard'
    expect(page).to have_link "View Menu Items", href: admin_items_path
    expect(page).to have_link "View Orders", href: admin_orders_path
    expect(page).to have_link "Create New Item", href: new_admin_item_path
    expect(page).to have_link "Create New Category", href: new_admin_category_path
  end
end
