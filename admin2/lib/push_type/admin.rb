require 'push_type_core'
require 'push_type_api'

module PushType

  module Admin
    PushType.register_engine self, mount: 'admin'
  end
  
end

require 'push_type/admin/engine'

require 'push_type/webpack'