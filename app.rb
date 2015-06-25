require 'sinatra/base'
require 'sinatra/json'
require 'bundler/setup'
class Frank < Sinatra::Base
  Bundler.require(:default, settings.environment)
  require 'tilt/erb'
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end
  configure do
    enable :logging
    enable :sessions
    set :last_boot, Time.now.to_i
    set :default_redirect, ENV['DEFAULT_REDIRECT'] || 'http://www.thefutureproject.org/404.html'
  end

  # set up google auth
  require './auth'
  #initialize the database
  require './db'
  # require all models
  Dir["./models/*.rb"].each{|model| require model }
  #load routes
  require './routes'

end

