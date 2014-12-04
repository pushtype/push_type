require 'generators/push_type/dummy/dummy_generator'
require 'generators/push_type/install/install_generator'
require 'generators/push_type/node/node_generator'

namespace :common do

  task :test_app, :lib_name, :base_path, :dummy_path do |t, args|
    args.with_defaults lib_name: 'push_type_core', base_path: './', dummy_path: 'test/dummy'

    PushType::DummyGenerator.start ["--lib_name=#{ args[:lib_name] }", "--path=#{ args[:dummy_path] }", "--quiet"]

    Dir.chdir File.join(args[:base_path], args[:dummy_path]) do
      PushType::InstallGenerator.start ["--migrate=false", "--quiet"]
      PushType::NodeGenerator.start ["page", "--quiet"]
      system 'bundle exec rake db:drop db:create db:migrate'
    end
  end

end