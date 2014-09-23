require_relative '../feature_spec_helper'

describe 'the admin dashboard', type: :feature do
  include AdminHelper

  before { login_as_admin }
  
  it 'has links' do
    visit '/admin_dashboard'
    expect(page).to have_link "Users", href: admin_users_path
    expect(page).to have_link "Listings", href: admin_orders_path
  end
end
