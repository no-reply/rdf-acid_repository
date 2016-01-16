#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-acid_repository'
  gem.homepage           = 'http://ruby-rdf.github.com/rdf-acid_repository'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'An in-memory repository using a functional data ' \
                           'structure.'
  gem.description        = 'A drop-in replacement for RDF::Repository. Uses ' \
                           'full persistence within a transaction scope to ' \
                           'get cheap snapshot isolation.'
  gem.rubyforge_project  = 'rdf'

  gem.authors            = ['Tom Johnson']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CREDITS README UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 2.0'
  gem.requirements               = []

  gem.add_runtime_dependency     'hamster', '~> 2.0'

  gem.add_development_dependency 'rdf-spec',    '~> 1.1', '>= 1.1.13'
  gem.add_development_dependency 'rdf-rdfxml',  '~> 1.1'
  gem.add_development_dependency 'rdf-rdfa',    '~> 1.1'
  gem.add_development_dependency 'rdf-turtle',  '~> 1.1'
  gem.add_development_dependency 'rdf-vocab',   '~> 0.8'
  gem.add_development_dependency 'rdf-xsd',     '~> 1.1'
  gem.add_development_dependency 'rest-client', '~> 1.7'
  gem.add_development_dependency 'rspec',       '~> 3.0'
  gem.add_development_dependency 'rspec-its',   '~> 1.0'
  gem.add_development_dependency 'webmock',     '~> 1.17'
  gem.add_development_dependency 'yard',        '~> 0.8'
  gem.add_development_dependency 'faraday',     '~> 0.9'
  gem.add_development_dependency 'faraday_middleware', '~> 0.9'

  gem.post_install_message       = nil
end
