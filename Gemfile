source "https://rubygems.org"

gemspec

group :develop do
  gem "rdf",      git: "git://github.com/ruby-rdf/rdf.git", branch: "develop"
  gem "rdf-spec",       git: "git://github.com/ruby-rdf/rdf-spec.git", branch: "develop"
end

group :debug do
  gem 'psych', platforms: [:mri, :rbx]
  gem "wirble"
  gem "redcarpet", platforms: :ruby
  gem "byebug", platforms: :mri
  gem 'guard-rspec'
end

group :test do
  gem "rake"
  gem "equivalent-xml"
  gem 'fasterer'
  gem 'simplecov',  require: false, platform: :mri
  gem 'coveralls',  require: false, platform: :mri
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubinius', '~> 2.0'
end
