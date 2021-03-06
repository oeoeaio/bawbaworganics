require 'devise'

module ControllerAuth
  extend ActiveSupport::Concern

  included do
    include Devise::Test::ControllerHelpers
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:admin)
    sign_in admin
    admin
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user
    user
  end
end
