require "sinatra"
require "bundler/setup"
Bundler.require(:default, settings.environment)
require "tilt/erb"
require "sass/plugin/rack"

require "./config/environments"

# set up google auth
require "./db/init"
require_all "app/models"
require_all "app/concerns"
require_all "app/controllers"
run Sinatra::Application
