#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

task :default => :test
