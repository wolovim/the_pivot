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
      visit new_item_image_path(item)
      attach_file "item_image_image", 'spec/fixtures/missing.jpg'
      click_link_or_button 'Upload Photo'
    end

    expect(item.item_images.count). to eq 2
  end
end