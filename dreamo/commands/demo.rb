module Dreamo
  module Commands
    class Demo < SlackRubyBot::Commands::Base

      triggers "ready for a demo"

      def self.call client, data, match
        msg = "Ready, <@#{data.user}>. I think."
        client.say channel: data.channel, text: msg
      end

    end
  end
end
