DB = case settings.environment
when :test then Sequel.sqlite
when :development then Sequel.connect("sqlite://#{Dir.pwd}/development.sqlite")
else
  Sequel.connect(ENV['DATABASE_URL'])
end
require_relative 'record'

