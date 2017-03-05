require 'generators/push_type/dummy/dummy_generator'
require 'generators/push_type/install/install_generator'
require 'generators/push_type/node/node_generator'
require 'generators/push_type/structure/structure_generator'
require 'generators/push_type/presenter/presenter_generator'

namespace :common do

  task :test_app, :lib_name, :base_path, :dummy_path, :skip_javascript do |t, args|
    args.with_defaults lib_name: 'push_type_core', base_path: './', dummy_path: 'test/dummy', skip_javascript: false

    opts = ["--lib_name=#{ args[:lib_name] }", "--path=#{ args[:dummy_path] }", '--quiet']
    opts.push '--skip-javascript' if args[:skip_javascript]

    PushType::DummyGenerator.start opts

    Dir.chdir File.join(args[:base_path], args[:dummy_path]) do
      system 'bin/rails db:environment:set RAILS_ENV=test'
      system 'bin/rails db:drop db:create'
      PushType::InstallGenerator.start ['--quiet']
      PushType::NodeGenerator.start ['page', '--quiet']
      PushType::PresenterGenerator.start ['page', '--quiet']
      PushType::StructureGenerator.start ['location', '--quiet']
    end
  end

end