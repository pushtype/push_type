require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

require '<%= lib_name %>'

module Dummy
  class Application < Rails::Application
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
  end
end

