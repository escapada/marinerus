# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-ships'
  s.version           = '1.0'
  s.authors = ['Refinery']
  s.description       = 'Ruby on Rails Ships extension for Refinery CMS'
  s.date              = '2015-08-30'
  s.summary           = 'Ships extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.1.5'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.1.5'
end
