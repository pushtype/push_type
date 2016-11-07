ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../test/dummy/config/environment.rb',  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../test/dummy/db/migrate', __FILE__)]
require 'rails/test_help'

# Require PushType testing setup
require 'push_type/testing/setup'
require 'push_type/testing/factories'
require File.expand_path('../factories.rb', __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActionController::TestCase
  include Devise::Test::ControllerHelpers

  before :all do
    @routes = PushType::Admin::Engine.routes
  end
end
