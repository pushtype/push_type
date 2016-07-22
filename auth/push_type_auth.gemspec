# Maintain your gem's version:
require File.expand_path('../../core/lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type_auth'
  s.version       = PushType::VERSION
  s.summary       = %q{Provides authentication to PushType CMS using Devise.}
  s.description   = %q{Provides authentication to PushType CMS using Devise. Requires push_type_admin. PushType is a new generation of content management system for Ruby on Rails.}

  s.files         = Dir['{app,config,db,lib,vendor}/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)
  s.test_files    = Dir['test/**/*']

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://www.pushtype.org'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',  PushType::VERSION
  s.add_dependency 'push_type_admin', PushType::VERSION
  s.add_dependency 'devise',          '~> 4.2.0'
  s.add_dependency 'highline',        '~> 1.7.8'

  s.add_development_dependency 'minitest-spec-rails', '~> 5.4.0'
  s.add_development_dependency 'database_cleaner',    '~> 1.5.3'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.7.0'
  s.add_development_dependency 'rails-controller-testing', '~> 0.1.1'
  s.add_development_dependency 'listen',              '~> 3.1.5'
end
