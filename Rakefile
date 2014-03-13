require 'rspec/core/rake_task'
require 'quality/rake/task'

RSpec::Core::RakeTask.new(:spec)
Quality::Rake::Task.new do |t|
  t.ruby_dirs = %w{spec}
end

task default: :spec

task :show do
  require_relative 'coverage'
end
