ENV["RACK_ENV"] ||= "development"

module Database

  def self.connect
    Sequel::Model.plugin :timestamps
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

DB ||= Database.connect
