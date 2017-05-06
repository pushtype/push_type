# Maintain your gem's version:
require File.expand_path('../../core/lib/push_type/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'push_type_admin'
  s.version       = PushType::VERSION
  s.summary       = %q{The admin user interface for PushType CMS.}
  s.description   = %q{The admin user interface for PushType CMS. PushType is a new generation of content management system for Ruby on Rails.}

  s.files         = Dir['{app,config,db,lib,vendor}/**/*', 'README.md', 'LICENSE.md']
  s.require_paths = %w(lib)
  s.test_files    = Dir['test/**/*']

  s.authors       = ['Aaron Russell']
  s.email         = ['aaron@gc4.co.uk']
  s.homepage      = 'http://www.pushtype.org'
  s.license       = 'MIT'

  s.add_dependency 'push_type_core',              PushType::VERSION
  s.add_dependency 'haml-rails',                  '~> 1.0.0'
  s.add_dependency 'coffee-rails',                '~> 4.2.1'
  s.add_dependency 'jquery-rails',                '~> 4.3.1'
  s.add_dependency 'foundation-rails',            '~> 5.5.3.2'
  s.add_dependency 'foundation-icons-sass-rails', '~> 3.0.0'
  s.add_dependency 'pickadate-rails',             '~> 3.5.6.0'
  s.add_dependency 'selectize-rails',             '~> 0.12.4'
  s.add_dependency 'codemirror-rails',            '~> 5.16.0'
  s.add_dependency 'wysiwyg-rails',               '~> 2.6.0'
  s.add_dependency 'font-awesome-rails',          '~> 4.7.0.2'
  s.add_dependency 'turbolinks',                  '~> 5.0.1'
  s.add_dependency 'breadcrumbs',                 '~> 0.1.7'
  s.add_dependency 'kaminari',                    '~> 1.0.1'
  s.add_dependency 'premailer-rails',             '~> 1.9.6'
end
