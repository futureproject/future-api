ENV['RACK_ENV'] ||= 'development'
DB = case ENV["RACK_ENV"]
when 'test' then Sequel.sqlite
when 'development' then Sequel.connect("sqlite://#{Dir.pwd}/development.sqlite")
else
  Sequel.connect(ENV['DATABASE_URL'])
end
require_relative 'record'

