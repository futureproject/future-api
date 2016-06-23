module Dreamo
  class Bot < SlackRubyBot::Bot
  end
end

module SlackRubyBot
  module Commands
    class Base
      # matches phrases by word boundary, and requires that
      # the bot be menitoned by name in a channel
      def self.triggers(*phrases)
        match /^(?<bot>[[:alnum:][:punct:]@<>]*).*(?<expression>\b(#{phrases.join("|")})\b)/
      end
    end
  end
end

SlackRubyBot.configure do |config|
  config.send_gifs = false
  SlackRubyBot::Client.logger.level = Logger::WARN
end

Dir["#{File.dirname(__FILE__)}/{commands}/*.rb"].each do |file|
  require file
end

