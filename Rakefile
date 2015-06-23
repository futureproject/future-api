require_relative 'app'
namespace :db do
  desc "seed the database"
  task :seed do
    if !Frank.database.table_exists?(:redirects)
      Frank.database.create_table :redirects do
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
  desc "import the data from heroku"
  task :import do
    begin
      %x(dropdb dbrb_development)
    end
    %x(createdb dbrb_development)
    %x(pg_dump -t go_redirects dreamos_development | psql dbrb_development)
    Frank.database.rename_table :go_redirects, :redirects
  end
end

