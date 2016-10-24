# Maintain your gem's version:
require File.expand_path('../core/lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type'
  s.version       = PushType::VERSION
  s.summary       = %q{PushType is a new generation of content management system for Ruby on Rails.}
  s.description   = %q{PushType is a modern, open source content management system for Ruby on Rails. It takes advantage of powerful new features available in the latest versions of Rails and PostgreSQL.}

  s.files         = Dir['lib/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://www.pushtype.org'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',    PushType::VERSION
  s.add_dependency 'push_type_api',     PushType::VERSION
  s.add_dependency 'push_type_admin',   PushType::VERSION
  s.add_dependency 'push_type_auth',    PushType::VERSION
end
