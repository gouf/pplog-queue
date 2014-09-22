source "https://rubygems.org"

group :test, :deployment, :development do
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
group :test, :development do
  gem 'coveralls', require: false
  gem 'guard-rspec', require: false
  gem 'rspec'
  gem 'webmock', require: false
  gem 'fakeweb'
  gem 'fuubar'
  gem 'reek'
  gem 'dotenv'
  gem 'pry-coolline'
end
