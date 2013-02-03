require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new :spec
Cucumber::Rake::Task.new  :cuke

task default: [ :spec, :cuke ]
