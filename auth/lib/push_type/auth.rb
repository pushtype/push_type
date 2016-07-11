require 'push_type_core'
require 'push_type_api'
require 'push_type_admin'

require 'devise'
require 'simple_token_authentication'

module PushType

  module Auth
    ActiveSupport.run_load_hooks(:push_type_auth, PushType)
  end
  
end

require 'push_type/auth/engine'

