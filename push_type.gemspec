$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'push_type/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type'
  s.version       = PushType::VERSION
  s.summary       = %q{A content management system for Ruby on Rails.}
  s.description   = %q{PushType is an open source content management system for Ruby on Rails. PushType does a great job of managing content, then gets out of the way so Rails can do the rest.}

  s.files         = Dir['lib/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://type.pushcode.com'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',    PushType::VERSION
  s.add_dependency 'push_type_admin',   PushType::VERSION
  s.add_dependency 'push_type_wysiwyg', PushType::VERSION
  s.add_dependency 'push_type_auth',    PushType::VERSION

  s.add_development_dependency 'minitest-rails',      '~> 2.1.1'
  s.add_development_dependency 'database_cleaner',    '~> 1.4.0'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5.0'
end
