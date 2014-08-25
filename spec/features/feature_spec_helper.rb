require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

module AdminHelper
  def login_as_admin
    admin = create(:user)
    visit login_path
    fill_in 'email address', :with => admin.email
    fill_in 'password', :with => admin.password
    click_button("Login")
  end
end
