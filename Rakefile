require "bundler"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
$LOAD_PATH.unshift(File.join(Bundler.root.to_s,'lib'))
require "database_patcher/rake_task"

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
