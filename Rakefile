require_relative 'app'

namespace :db do
  desc "migrate to the latest db version"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}..."
      Sequel::Migrator.run(settings.database, "db/migrations", target: args[:version].to_i)
      puts "done."
    else
      puts "Migrating to latest..."
      Sequel::Migrator.run settings.database, "db/migrations"
      puts "done."
    end
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end
task :default => :spec
