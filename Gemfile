source 'https://rubygems.org'
ruby '2.1.4'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: false
gem 'sequel'
gem 'puma'
gem 'rake'
group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sinatra-reloader'
  gem 'sqlite3'
end
