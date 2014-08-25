require_relative '../feature_spec_helper'

describe 'the admin dashboard', type: :feature do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end
  
  it 'has links' do
    visit '/admin_dashboard'
    expect(page).to have_link "View Menu Items", href: admin_items_path
    expect(page).to have_link "View Orders", href: admin_orders_path
    expect(page).to have_link "Create New Item", href: new_admin_item_path
    expect(page).to have_link "Create New Category", href: new_admin_category_path
  end
end
