require 'sinatra'
require 'bundler/setup'
Bundler.require(:default, settings.environment)
require_relative 'models/init'
configure do
  enable :logging
end

configure :development do
  register Sinatra::Reloader
end

get '/' do
  records = Record.all
  json records
end
