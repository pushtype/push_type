begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'push_type/version'
require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PushType'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('{core,admin,auth}/{app,lib}/**/*.rb')
end

Bundler::GemHelper.install_tasks

task default: :test


PUSH_TYPE_LIBS = %w(core api admin auth)

desc "Runs all tests in all PushType engines"
task :test do
  ENV['RAILS_ENV'] = ENV['PUSH_TYPE_ENV'] = 'test'
  PUSH_TYPE_LIBS.each do |dir|
    Dir.chdir dir do
      system 'bundle exec rake test_app'
      system 'bundle exec rake test' or exit(1)
    end
  end
end

namespace :gems do
  desc "Build all PushType engine gems"
  task :build do
    Rake::Task['build'].invoke
    PUSH_TYPE_LIBS.each do |dir|
      Dir.chdir dir do
        system 'bundle exec rake build'
        system 'mv pkg/* ../pkg && rm -r pkg'
      end
    end
  end

  desc "Remove all PushType engines from pkg/"
  task :clean do
    puts 'Deleting gems from pkg/'
    system 'rm pkg/*'
  end

  desc "Install all PushType engines into system gems"
  task :install do
    Rake::Task['gems:build'].invoke
    gem_paths = Dir["pkg/push_type*-#{ PushType::VERSION }.gem"]
    system "gem install #{ gem_paths.join(' ') }"
  end

  desc "Install all PushType engines into system gems"
  task :release do
    Rake::Task['gems:build'].invoke
    Dir["pkg/push_type*-#{ PushType::VERSION }.gem"].each do |gem_path|
      system "gem push #{ gem_path }"
    end
  end
end
