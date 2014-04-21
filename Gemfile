source "https://rubygems.org"

ruby '2.1.1'

group :test, :deployment do
  gem 'mechanize'
  gem 'sinatra'
  gem 'yaml_record'
  gem 'rake', '>= 10.2.2'
  gem 'sinatra-contrib'
end
group :deployment do
  gem 'unicorn'
  gem 'mina'
end
group :test do
  gem 'guard-rspec', require: false
  gem 'rspec'
  gem 'should_clean', require: false
  gem 'should_not', require: false
  gem 'webmock', require: false
  gem 'coveralls', require: false
  gem 'fakeweb'
  gem 'fuubar'
  gem 'reek'
  gem 'quality'
  gem 'dotenv'
end
