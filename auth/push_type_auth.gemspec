$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require File.expand_path('../../lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type_auth'
  s.version       = PushType::VERSION
  s.summary       = %q{Provides authentication to the PushType content management system using Devise.}
  s.description   = %q{Provides authentication to the PushType content management system using Devise. Requires push_type_admin.}

  s.files         = Dir['{app,config,db,lib,vendor}/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)
  s.test_files    = Dir['test/**/*']

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://type.pushcode.com'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',  PushType::VERSION
  s.add_dependency 'push_type_admin', PushType::VERSION
  s.add_dependency 'devise',          '~> 3.4.1'
  s.add_dependency 'highline',        '~> 1.6.21'

  s.add_development_dependency 'minitest-rails',      '~> 2.1.1'
  s.add_development_dependency 'database_cleaner',    '~> 1.f.0'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5.0'
end
