require 'push_type_core'

require 'jbuilder'
require 'kaminari'

module PushType
  module Api
    PushType.register_engine self, mount: 'api'
  end
end

require 'push_type/api/engine'
