ENV["RACK_ENV"] = 'test'
require 'pry'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'
require_relative '../app'
require_relative 'factories'
require_all "#{Dir.pwd}/spec/support"
Capybara.app = Frank
Capybara.default_selector = :css

