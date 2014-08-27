require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

module AdminHelper
  def login_as_admin
    admin = build(:user, role: 'admin')
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user) { admin }
  end
end
