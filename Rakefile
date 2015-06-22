require_relative 'app'
namespace :db do
  desc "seed the database"
  task :seed do
    if !DB.table_exists?(:records)
      DB.create_table :records do
        primary_key :id
        String :name
        DateTime :created_at
        DateTime :updated_at
      end
    end
    records = DB[:records]
    100.times do |i|
      records.insert(name: "Number #{i}", updated_at: Time.now, created_at: Time.now)
    end
  end
end

