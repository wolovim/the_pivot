require_relative 'feature_spec_helper'

describe 'host', type: :feature do
  it 'can add multiple images to an item' do
    user = FactoryGirl.create :user, role: "default"
    item = FactoryGirl.create :item, user_id: user.id

    visit '/login'
    fill_in 'email address', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'

    2.times do
      visit items_user_path(user)
      click_link_or_button 'Edit Listing'
      attach_file "item_item_image_image", 'spec/fixtures/missing.jpg'
      click_link_or_button 'Update Listing'
    end

    expect(item.item_images.count). to eq 2
  end
end