ENV["RACK_ENV"] = "test"
ENV["SESSION_SECRET"] ||= "12345"
require "pry"
require "capybara"
require "capybara/rspec"
require "capybara/dsl"
require_relative "../main"
require_all "#{Dir.pwd}/spec/support"
Capybara.app = Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first
Capybara.default_selector = :css

#set default redirect to tfp.org, so that it doesn't 404 in tests
App.set :default_redirect, "http://www.thefutureproject.org/"

RSpec.configure do |config|
  config.before(:each) do
    enable_automatic_auth
  end
  config.color = true
  App.cache.flush
end
