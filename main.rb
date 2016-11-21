require "sinatra/base"
require "bundler/setup"

class App < Sinatra::Base
  Bundler.require(:default, settings.environment)

  # load Environment variables
  # (foreman handles ENV variables in production)
  configure :test, :development do
    Dotenv.load
  end

  require "sinatra/json"

  # load Dreamo The Talking Fish
  require "./dreamo/bot"

  configure do
    use Rack::Session::Cookie, expire_after: 259200, secret: ENV["SESSION_SECRET"]
    use Rack::Cache
    use Rack::Deflater
    use Rack::Flash
    use Rack::PostBodyContentTypeParser # make the params hash work as expected
    enable :logging
    #make sure redirects 404 to thefutureproject.org's 404 page
    set :default_redirect, ENV["DEFAULT_REDIRECT"] || "http://www.thefutureproject.org/404.html"
    # start memecache
    set :cache, Dalli::Client.new
    set :raise_errors, true

    # log errors via raygun
    Raygun.setup do |config|
      config.api_key = ENV['RAYGUN_APIKEY']
    end
    use Raygun::Middleware::RackExceptionInterceptor
  end

  configure :production do
    # cache static assets agressively, because
    # Sprockets uses digests to guarantee unique filenames
    set :static_cache_control, [:public, :max_age => 7200]

    # define Airtable schema
    Airmodel.bases "#{App.root}/config/db/production.yml"
  end

  configure :development, :test do
    # debug modules, move to next group if you need them while running tests
    Dir["#{settings.root}/debug/*.rb"].each{|f| require f}

    # define Airtable schema
    Airmodel.bases "#{App.root}/config/db/development.yml"
  end


  # all the good stuff
  Dir["#{settings.root}/{lib,helpers,models}/*.rb"].each{|f| require f}

  #require "./assets/init"

end

class ApplicationController < App
  Dir["#{settings.root}/controllers/*.rb"].each{|f| require f}
end

