require 'push_type_core'
require 'push_type_admin'

require 'wysiwyg-rails'
require 'font-awesome-rails'


module PushType

  module Wysiwyg
    ActiveSupport.run_load_hooks(:push_type_wysiwyg, PushType)
  end

end

require 'push_type/wysiwyg/engine'