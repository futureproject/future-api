require "./main"
task :environment do
  Dotenv.load
end

Dir["lib/tasks/*.rake"].each {|f| load f }

if defined?(RSpec)
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('spec/**/*_spec.rb')
    t.rspec_opts = '--format documentation'
  end
  task :default => :spec
end
