require 'sinatra/base'
require 'bundler/setup'
class Frank < Sinatra::Base
  Bundler.require(:default, settings.environment)
  require 'sinatra/json'
  require_relative 'models/init'
  configure do
    enable :logging
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    json Record.all
  end
end

