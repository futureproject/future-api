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

  configure do
    set :views, "#{root}/app/views"
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
    Airmodel.bases "#{root}/config/db/production.yml"

    #force SSL in production
    use Rack::SSL
  end

  configure :development, :test do
    set :assets_compiled, false
    # debug modules, not loaded in production
    Dir["#{settings.root}/debug/*.rb"].each{|f| require f}

    # define Airtable schema
    Airmodel.bases ENV['AIRTABLE_CONFIG_PATH'] || "#{root}/config/db/development.yml"

  end

  # all the good stuff
  Dir["#{root}/app/{lib,helpers,models}/*.rb"].each{|f| require f}

end

class ApplicationController < App
  Dir["#{root}/app/controllers/*.rb"].each{|f| require f}
end

