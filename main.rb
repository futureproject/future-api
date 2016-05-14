require "sinatra/base"
require "bundler/setup"

class App < Sinatra::Base
  require_relative "config/environments"
  Dir["#{settings.root}/{models,helpers,routes}/*.rb"].each{|f| require f}
end

