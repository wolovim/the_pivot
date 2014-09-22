require_relative 'feature_spec_helper'

describe 'user', type: :feature do
  describe 'traveler' do
    it 'can view listings for a particular host' do
      user = create :user, role: "default"
      item = create :item, title: "MyTitle", user_id: user.id
      item.item_images.create!

      visit items_user_path(user)

      expect(page).not_to have_content "Edit Listing"
      expect(page).not_to have_button "Create New Listing"
      expect(page).to have_button "Book it!"
      expect(page).to have_content "MyTitle"
    end
  end  

  describe 'host' do
    it 'can view and edit their own listings' do
      user = create :user, role: "default"
      item = create :item, title: "MyTitle", user_id: user.id
      item.item_images.create!

      visit '/login'
      fill_in 'email address', with: user.email
      fill_in 'password', with: user.password
      click_button 'Login'

      visit items_user_path(user)

      expect(page).not_to have_content "Book it!"
      expect(page).to have_link "Edit Listing"
    end
  end
end