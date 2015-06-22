require_relative 'app'
namespace :db do
  desc "seed the database"
  task :seed do
    DataMapper.auto_upgrade!
    100.times do |i|
      Record.create(name: "Number #{i}", updated_at: Time.now, created_at: Time.now)
    end
  end
end

