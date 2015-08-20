# Maintain your gem's version:
require File.expand_path('../core/lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type'
  s.version       = PushType::VERSION
  s.summary       = %q{PushType is a modern, open source content management system for Ruby on Rails.}
  s.description   = %q{PushType is a modern, open source content management system for Ruby on Rails, built around the idea that your job should be made easier by the tools you chose to work with.}

  s.files         = Dir['lib/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://www.pushtype.org'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',    PushType::VERSION
  s.add_dependency 'push_type_admin',   PushType::VERSION
  s.add_dependency 'push_type_wysiwyg', PushType::VERSION
  s.add_dependency 'push_type_auth',    PushType::VERSION

  s.add_development_dependency 'minitest-rails',      '~> 2.2.0'
  s.add_development_dependency 'database_cleaner',    '~> 1.4.0'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5.0'
end
