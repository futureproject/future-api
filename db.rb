ENV['RACK_ENV'] ||= 'development'

class Frank < Sinatra::Base
  def self.set_database
    case ENV["RACK_ENV"]
    when 'development'
      set :database, Sequel.postgres(database: 'tfp_redirects_development', host: 'localhost')
    else
      set :database, Sequel.connect(ENV['DATABASE_URL'], max_connections: ENV['MAX_DB_CONNECTIONS'] || 4, single_threaded: false)
    end
  end

  configure do
    self.set_database
  end

end

