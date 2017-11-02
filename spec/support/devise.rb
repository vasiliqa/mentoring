module Devise
  module ControllerMacros
    def login_user(user = nil)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = user || FactoryBot.create(:user)
      sign_in @user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::ControllerMacros, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
end
