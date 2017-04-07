require 'minitest-spec-rails'
require 'minitest/mock'
require 'minitest/pride'
require 'database_cleaner'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

#Rails.backtrace_cleaner.remove_silencers!

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with :truncation
Dragonfly.app.use_datastore :memory

ActiveSupport::Deprecation.silenced = true

class ActiveSupport::TestCase
  # Due to test weirdness / dodgy code need to reference some classes
  Page && Location

  before :each do
    DatabaseCleaner.start
    PushType.config.root_nodes = :all
    PushType.config.unexposed_nodes = []
  end

  after :each do
    DatabaseCleaner.clean
  end

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  if Rails.version.to_f >= 5
    require 'rails-controller-testing'
    include ::Rails::Controller::Testing::TestProcess
    include ::Rails::Controller::Testing::TemplateAssertions
    include ::Rails::Controller::Testing::Integration
  end
end