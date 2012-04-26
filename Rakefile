require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc "Irb with source_image loaded"
task :shell do
  exec "bundle exec irb -r source_image"
end

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(-fs --color)
end

task :default => :spec
