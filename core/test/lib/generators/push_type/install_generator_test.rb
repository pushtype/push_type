require 'test_helper'
require "generators/push_type/install/install_generator"

module PushType
  class InstallGeneratorTest < Rails::Generators::TestCase
    tests InstallGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      FileUtils.mkdir Rails.root.join('tmp/generators/config')
      FileUtils.cp Rails.root.join('config/routes.rb'), Rails.root.join('tmp/generators/config/')
      run_generator ['--no-migrate']
    end

    it { assert_file 'config/initializers/push_type.rb', %r{PushType.setup do |config|} }
    it { assert_file 'config/routes.rb', %r{mount_push_type} }
  end
end
