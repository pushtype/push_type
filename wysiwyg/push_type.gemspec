$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require File.expand_path('../../lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type_wysiwyg'
  s.version       = PushType::VERSION
  s.summary       = %q{Provides a WYSIWYG editor to the PushType content management system using Froala.}
  s.description   = %q{Provides a WYSIWYG editor to the PushType content management system using Froala. Requires push_type_admin.}

  s.files         = Dir['{app,config,db,lib,vendor}/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)
  s.test_files    = Dir['test/**/*']

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://type.pushcode.com'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',  PushType::VERSION
  s.add_dependency 'push_type_admin', PushType::VERSION
  s.add_dependency 'wysiwyg-rails',   '1.2.4'

  s.add_development_dependency 'minitest-rails',      '~> 2.1.1'
  s.add_development_dependency 'database_cleaner',    '~> 1.3.0'
  s.add_development_dependency 'factory_girl_rails',  '~> 4.5.0'
end