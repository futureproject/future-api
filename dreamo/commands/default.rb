module Dreamo
  module Commands
    class Default < SlackRubyBot::Commands::Base
      command "about"
      match(/^(?<bot>[[:alnum:][:punct:]@<>]*)$/u)

      def self.call client, data, match
        msg = "Helpful fish, version 0.0.1"
        client.say channel: data.channel, text: msg
      end

    end
  end
end
