unless ENV['PUSH_TYPE_ENV'] == 'test'
  require 'push_type_core'
  require 'push_type_api'
  require 'push_type_admin'
  require 'push_type_auth'
end