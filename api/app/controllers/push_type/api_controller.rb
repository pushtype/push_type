module PushType
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
  end
end
