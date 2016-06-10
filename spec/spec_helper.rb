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
FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions

# monkeypatch FactoryGirl to be compatible with Sequel
Sequel::Model.send :alias_method, :save!, :save

DatabaseCleaner.strategy = :transaction
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:each) do
    DatabaseCleaner.start
    enable_automatic_auth
  end
  config.append_after(:each) do
    DatabaseCleaner.clean
  end
  config.color = true
end
