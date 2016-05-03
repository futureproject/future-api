require "sinatra"
require "bundler/setup"

Bundler.require(:default, settings.environment)
require "tilt/erb"
require "sass/plugin/rack"
configure :development do
  require "sinatra/reloader"
  register Sinatra::Reloader
end
configure do
  Sass::Plugin.options[:style] = :compressed
  use Sass::Plugin::Rack
  enable :logging
  enable :sessions
  set :last_boot, Time.now.to_i
  set :default_redirect, ENV["DEFAULT_REDIRECT"] || "http://www.thefutureproject.org/404.html"
end

# set up google auth
require "./auth"
# set up database
require "./db/init"
# require all models
require_all "models"
#load routes
require_all "routes"

