require 'database_cleaner'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with :truncation
Dragonfly.app.use_datastore :memory

class ActiveSupport::TestCase
  before :each do
    # Due to test weirdness / dodgy code need to call Category
    Category
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