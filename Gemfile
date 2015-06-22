source 'https://rubygems.org'
ruby '2.1.4'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: false
gem 'data_mapper'
gem 'puma'
gem 'rake'
group :production do
  gem 'pg'
  gem 'dm-postgres-adapter'
end
group :development, :test do
  gem 'sinatra-reloader'
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'
end
