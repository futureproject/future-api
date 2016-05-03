configure do
  Sass::Plugin.options[:style] = :compressed
  use Sass::Plugin::Rack
  enable :logging
  enable :sessions
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
