require "bundler/gem_tasks"

require 'rake/testtask'

task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  # test.pattern = 'test/**/*_test.rb'
  test.test_files = Dir.glob("test/**/*_test.rb")
  test.verbose = true
  # test.warning = true
end