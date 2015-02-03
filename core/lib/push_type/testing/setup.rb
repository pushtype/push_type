require 'database_cleaner'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with :truncation
Dragonfly.app.use_datastore :memory

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

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
  before :each do
    @routes = PushType::Core::Engine.routes
  end
end