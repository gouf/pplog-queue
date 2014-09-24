source "https://rubygems.org"

group :test, :deployment, :development do
  gem 'mechanize'
  gem 'sinatra'
  gem 'yaml_record'
  gem 'rake', '>= 10.2.2'
  gem 'sinatra-contrib'
  gem 'sinatra-bootstrap', require: 'sinatra/bootstrap'
end
group :deployment do
  gem 'mina'
end
group :test, :development do
  gem 'coveralls', require: false
  gem 'rspec'
  gem 'webmock', require: false
  gem 'fakeweb'
  gem 'fuubar'
  gem 'dotenv'
end
group :development do
  gem 'guard-rspec', require: false
  gem 'reek'
  gem 'pry-coolline'
  gem 'rubocop'
  gem 'guard-rubocop'
end
