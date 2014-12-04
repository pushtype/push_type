require 'database_cleaner'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

DatabaseCleaner.strategy = :truncation
Dragonfly.app.use_datastore :memory

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  before :each do
    @routes = PushType::Engine.routes
  end
end