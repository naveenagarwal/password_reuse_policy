require "bundler/gem_tasks"
# require "rspec/core/rake_task"

# RSpec::Core::RakeTask.new(:spec)

desc "run all tests in spec folder"
task :test do
  files = Dir.glob('spec/**/*.rb')
  files.each do |file|
    next if file == "spec/spec_helper.rb"
    puts `ruby #{file}` if file.end_with? "_spec.rb"
  end
end

task :default => :test
