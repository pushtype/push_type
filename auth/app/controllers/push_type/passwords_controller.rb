module PushType
  class PasswordsController < Devise::PasswordsController
    layout 'push_type/auth'
  end
end
