require "sinatra"
require "bundler/setup"

Bundler.require(:default, settings.environment)
require "tilt/erb"
require "sass/plugin/rack"
require "./config/environments"

# set up google auth
require "./auth"
# set up database
require "./db/init"
# require all models
require_all "models"
#load routes
require_all "routes"

