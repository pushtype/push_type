require 'push_type_core'

require 'coffee-rails'
require 'sass-rails'
require 'haml-rails'
require 'foundation-rails'
require 'foundation-icons-sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'wysiwyg-rails'
require 'font-awesome-rails'
require 'momentjs-rails'
require 'turbolinks'

require 'breadcrumbs'
require 'kaminari'

module PushType

  module Admin
  end
end

require 'push_type/admin/engine'

require 'push_type/breadcrumbs/foundation'