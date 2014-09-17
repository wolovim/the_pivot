require_relative 'feature_spec_helper'

describe 'host', type: :feature do
  it 'can add multiple images to an item' do
    user = FactoryGirl.create :user, role: "default"
    item = FactoryGirl.create :item, user_id: user.id

    visit '/login'
    fill_in 'email address', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'
    visit items_user_path(user)
    click_link_or_button 'Edit Listing'
    attach_file "item_image", 'spec/fixtures/missing.jpg'
    click_link_or_button 'Update Item'

    click_link_or_button item.title
    # assertions
  end
end