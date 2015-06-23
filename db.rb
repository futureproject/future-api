ENV['RACK_ENV'] ||= 'development'

class Frank < Sinatra::Base
  configure do
    case ENV["RACK_ENV"]
    when 'development'
      set :database, Sequel.postgres(database: 'tfp_redirects_development', host: 'localhost')
    else
      set :database, Sequel.connect(ENV['DATABASE_URL'])
    end
  end
end

