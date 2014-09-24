source "https://rubygems.org"

gem 'rspec'
group :test, :deployment, :development do
  gem 'mechanize'
  gem 'sinatra'
  gem 'yaml_record'
  gem 'rake', '>= 10.2.2'
  gem 'sinatra-contrib'
  gem 'sinatra-bootstrap', require: 'sinatra/bootstrap'
  gem 'foreman'
end
group :deployment do
  gem 'puma'
  gem 'mina'
end
group :test, :development do
  gem 'coveralls', require: false
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
