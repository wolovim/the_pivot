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
    user = create(:user, role: role)
    sign_in(user)
    user
  end

  def self.included(base)
    base.include SignInHelper
  end
end

module SignInHelper
  def sign_in(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:user_id) { user.id }
  end
end
