require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop'
require 'yard'
YARD::Rake::YardocTask.new

Rake::TestTask.new do |t|
  t.libs << 'lib/dmapparser'
  t.test_files = FileList['test/lib/**/*_test.rb']
  t.verbose = true
end

task test: :rubocop

task :rubocop do
  puts "Running RuboCop #{RuboCop::Version::STRING}"
  args = FileList['**/*.rb', 'Rakefile', 'dmapparser.gemspec', 'Gemfile']
  cli = RuboCop::CLI.new
  cli.run(args)
end

task default: :test
