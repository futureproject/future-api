Slack.configure do |config|
  config.token = ENV["SLACK_API_TOKEN"]
end

module Dreamo

  WEB_CLIENT = Slack::Web::Client.new
  COLORS = %w(#00c0ef #00d4bd #97e242 #fab406 #f63868 #d43da3 #3c82f7)

  class Bot < SlackRubyBot::Bot
  end

  module Commands
    class Base < SlackRubyBot::Commands::Base
      # matches phrases by word boundary, and requires that
      # the bot be menitoned by name in a channel
      def self.triggers(*phrases)
        match /^(?<bot>[[:alnum:][:punct:]@<>]*).*(?<expression>\b(#{phrases.join("|")})\b)/i
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

