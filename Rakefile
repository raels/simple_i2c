# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require 'github_changelog_generator/task'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]

GitHubChangelogGenerator::RakeTask.new :changelog do |config|  
  config.user = Bundler.settings['gem.github_username'] || 'username'
  config.project = 'simple_i2c'
  config.since_tag = '0.0.1'
  config.future_release = '0.1.0'
end