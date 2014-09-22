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
group :test do
end
group :test, :development do
  gem 'guard-rspec', require: false
  gem 'rspec'
  gem 'webmock', require: false
  gem 'fakeweb'
  gem 'fuubar'
  gem 'reek'
  gem 'quality'
  gem 'dotenv'
  gem 'coveralls', require: false
end
group :development do
  gem 'should_clean', require: false
  gem 'should_not', require: false
end
