require_relative '../feature_spec_helper'

describe 'the admin edit item view', type: :feature do
  before do
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end

  it 'displays the correct item information in the form' do
    item = Item.create(title: "Food", description: "Yumasdf", price: 10)
    visit edit_admin_item_path(item)
    expect(page.status_code).to eq 200
  end

end
