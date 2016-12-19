ruby "2.3.3"
source "https://rubygems.org"
gem "sinatra", require: false
gem "sinatra-contrib", require: false
gem "rack-contrib"
gem "puma"
gem "rake"
gem "omniauth-google-oauth2"
gem "require_all"
gem "sass"
gem "airmodel", "~> 0.0.2"
gem "memcachier"
gem "dalli"
gem "rack-cache"
gem "redcarpet"
gem "rack-flash3", require: "rack-flash"
gem "activesupport", require: "active_support/all"
gem "sendgrid-ruby"
gem "raygun4ruby"
gem 'namely'
gem 'rack-ssl', require: 'rack/ssl'

group :development, :test do
  gem "rspec"
  gem 'capybara'
  gem "poltergeist", require: "capybara/poltergeist"
  gem "rerun"
  gem "pry"
  gem "dotenv"
  gem "vcr"
  gem "webmock"
  gem "launchy"
end

group :bot do
  gem "slack-ruby-bot"
  gem "celluloid-io"
end
