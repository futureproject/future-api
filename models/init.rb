ENV['RACK_ENV'] ||= 'development'

class Frank < Sinatra::Base
  def self.set_database
    case ENV["RACK_ENV"]
    when 'development'
      set :database, Sequel.postgres('dbrb_development', host: 'localhost')
    else
      set :database, Sequel.connect(ENV['DATABASE_URL'])
    end
  end
end

Frank.set_database
require_relative 'record'

