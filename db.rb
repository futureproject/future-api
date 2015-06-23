ENV['RACK_ENV'] ||= 'development'

class Frank < Sinatra::Application
  def self.set_database
    case ENV["RACK_ENV"]
    when 'development'
      set :database, {adapter: 'postgres', database: 'tfp_redirects_development', host: 'localhost'}
    else
      set :database, ENV['DATABASE_URL']
    end
  end
end

Frank.set_database

