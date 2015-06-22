class Frank < Sinatra::Application
  require 'sass/plugin/rack'
  # use scss for stylesheets
  Sass::Plugin.options[:style] = :compressed
  use Sass::Plugin::Rack
end
