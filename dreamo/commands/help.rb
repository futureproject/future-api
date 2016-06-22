module Dreamo
  module Commands
    class Help < SlackRubyBot::Commands::Base

      match /^(help)/i

      def self.call client, data, match
        msg = "I'm *just* learning to talk. For now, message @chris.frank with questions."
        client.say channel: data.channel, text: msg
      end
    end
  end
end
