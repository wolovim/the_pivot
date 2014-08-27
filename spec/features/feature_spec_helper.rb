require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

module AdminHelper
  def login_as_admin
    log_me_in_with_role 'admin'
  end

  def log_me_in!
    log_me_in_with_role 'user'
  end

  def log_me_in_with_role(role)
    user = build(:user, role: role)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user) { user }
    user
  end
end
