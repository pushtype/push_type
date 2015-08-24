require 'push_type_core'
require 'push_type_admin'
require 'devise'

module PushType

  module Auth
    ActiveSupport.run_load_hooks(:push_type_auth, PushType)
  end
  
end

require 'push_type/auth/engine'

