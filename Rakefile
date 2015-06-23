require_relative 'app'
namespace :db do
  desc "seed the database"
  task :seed do
    if !Frank.database.table_exists?(:records)
      Frank.database.create_table :records do
        primary_key :id
        text :name
        timestamp :created_at
        timestamp :updated_at
      end
    end
    100.times do |i|
      Frank.database[:records].insert(name: "Number #{i}", updated_at: Time.now, created_at: Time.now)
    end
  end
end

