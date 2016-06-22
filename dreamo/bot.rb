module Dreamo
  class Bot < SlackRubyBot::Bot
  end
end

Dir["#{File.dirname(__FILE__)}/{commands,controllers}/*.rb"].each do |file|
  require file
end

SlackRubyBot.configure do |config|
  config.send_gifs = false
  #SlackRubyBot::Client.logger.level = Logger::WARN
end
