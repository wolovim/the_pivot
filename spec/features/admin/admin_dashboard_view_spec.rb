require_relative '../feature_spec_helper'

describe 'the admin dashboard', type: :feature do
  it 'has links' do
    visit '/admin_dashboard'
    expect(current_url).to eq("http://www.example.com/admin_dashboard")
  end
end
