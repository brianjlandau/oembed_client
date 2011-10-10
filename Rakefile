# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "oembed_client"
  gem.homepage = "http://github.com/brianjlandau/oembed_client"
  gem.license = "MIT"
  gem.summary = %Q{A simple abstract oEmbed Client for ruby.}
  gem.description = %Q{A simple abstract oEmbed Client for ruby.}
  gem.email = "brianjlandau@gmail.com"
  gem.authors = ["Brian Landau"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
  test.rcov_opts << '--sort coverage'
  test.rcov_opts << '--only-uncovered'
end

task :default => :test

