require 'push_type_core'

require 'coffee-rails'
require 'sass-rails'
require 'haml-rails'
require 'foundation-rails'
require 'foundation-icons-sass-rails'
require 'jquery-rails'
require 'angularjs-rails'
require 'momentjs-rails'
require 'pickadate-rails'
require 'selectize-rails'
require 'turbolinks'

require 'breadcrumbs'
require 'kaminari'
require 'premailer/rails'

module PushType

  module Admin
  end

  def self.admin_assets
    @@admin_assets ||= PushType::Admin::Assets.new
  end
end

require 'push_type/admin/assets'
require 'push_type/admin/engine'

require 'push_type/breadcrumbs/foundation'
