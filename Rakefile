begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PushType'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('{core,admin.auth}/lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

task default: :test


PUSH_TYPE_LIBS = %w(core admin auth)

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
