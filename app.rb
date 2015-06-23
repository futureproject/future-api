require 'sinatra'
require 'bundler/setup'
class Frank < Sinatra::Application
  Bundler.require(:default, settings.environment)
  require 'tilt'
  require 'tilt/erb'
  configure :development do
    register Sinatra::Reloader
  end
  configure do
    enable :logging
    register 
    set :last_boot, Time.now.to_i
    set :default_redirect, ENV['DEFAULT_REDIRECT'] || 'http://www.thefutureproject.org/404.html'
  end

  #initialize the database
  require './db'
  # require all models
  Dir["./models/*.rb"].each{|model| require model }
  #load routes
  require './routes'

end

