module PushType
  class SessionsController < Devise::SessionsController
    layout 'push_type/auth'
  end
end
