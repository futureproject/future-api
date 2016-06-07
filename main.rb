require "sinatra/base"
require "bundler/setup"

class App < Sinatra::Base
  Bundler.require(:default, settings.environment)
  require "tilt/erb"
  require "sass/plugin/rack"
  require "#{settings.root}/db/init"
  require "sinatra/json"
  configure do
    Sass::Plugin.options[:style] = :compressed
    use Sass::Plugin::Rack
    use Rack::Session::Cookie, expire_after: 259200, secret: ENV["SESSION_SECRET"]
    enable :logging
    set :last_boot, Time.now.to_i
    set :default_redirect, ENV["DEFAULT_REDIRECT"] || "http://www.thefutureproject.org/404.html"
  end
  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end
  configure :production do
    set :static_cache_control, [:public, :max_age => 7200]
  end

  Dir["#{settings.root}/{models,helpers,controllers}/*.rb"].each{|f| require f}
end

