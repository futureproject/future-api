ruby "2.3.1"
source "https://rubygems.org"
gem "sinatra", require: false
gem "sinatra-contrib", require: false
gem "puma"
gem "rake"
gem "pg"
gem "omniauth-google-oauth2"
gem "require_all"
gem "sass"
gem "airtable", git: "https://github.com/Airtable/airtable-ruby.git"
gem "memcachier"
gem "dalli"
gem "rack-cache"
gem "slack-ruby-bot"
gem "celluloid-io"
gem "sprockets"
gem "sprockets-helpers", require: "sinatra/sprockets-helpers"
group :development, :test do
  gem "rspec"
  gem "sinatra-reloader"
  gem "capybara"
  gem "pry"
  gem "dotenv"
  gem "vcr"
  gem "webmock"
end
# temporary, until Airtable removes activesupport dependency
gem "activesupport", require: "active_support/all"
