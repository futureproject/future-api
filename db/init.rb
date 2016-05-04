ENV["RACK_ENV"] ||= "development"

module Database
  # connect to the appropriate SQL database
  def self.connect
    case ENV["RACK_ENV"]
    when "development"
      Sequel.postgres(database: "go_dev", host: "localhost")
    when "test"
      Sequel.postgres(database: "go_test", host: "localhost")
    else
      Sequel.connect(ENV["DATABASE_URL"])
    end
  end
end

configure do
  set :database, Database.connect
end

