require 'push_type_core'

require 'coffee-rails'
require 'sass-rails'
require 'haml-rails'
require 'foundation-rails'
require 'foundation-icons-sass-rails'
require 'jquery-rails'
require 'pickadate-rails'
require 'selectize-rails'
require 'codemirror-rails'
require 'wysiwyg-rails'
require 'font-awesome-rails'
require 'turbolinks'

require 'breadcrumbs'
require 'kaminari'
# todo - remove this patch when possible
# ref https://github.com/amatsuda/kaminari/pull/322
require 'push_type/kaminari_patch'
require 'premailer/rails'

module PushType

  def self.admin_assets
    @@admin_assets ||= PushType::Admin::Assets.new
  end

  module Admin
    PushType.register_engine self, mount: 'admin'
  end
  
end

require 'push_type/admin/assets'
require 'push_type/admin/engine'

require 'push_type/breadcrumbs/foundation'
