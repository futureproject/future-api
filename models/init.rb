ENV['RACK_ENV'] ||= 'development'
DB = case ENV["RACK_ENV"]
when 'test' then
  DataMapper.setup(:default, 'sqlite::memory:')
when 'development'
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/development.sqlite")
else
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end
require_relative 'record'

