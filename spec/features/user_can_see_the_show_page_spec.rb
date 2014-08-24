require_relative 'feature_spec_helper'

describe "show page" do

  before do
    user = User.create email: 'test@gmail.com', first_name: 'bob', last_name: 'smith', password: 'password'

    visit login_path
    fill_in 'email address', :with => user.email
    fill_in 'password', :with => user.password
    click_button("Login")
    visit user_path(user)
  end

  it "shows the email form input field" do
      fill_in 'email address', :with => 'Robert'
      click_button("Submit")

      expect(page).to have_content("Robert")
  end
end
