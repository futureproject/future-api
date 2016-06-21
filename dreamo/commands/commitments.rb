module Dreamo
  module Commands
    class Commitments < SlackRubyBot::Commands::Base

      match /[^\S*](tasks|commitments).*?/i

      def self.call client, data, match
        msg = "You're 100% commitment-free"
        client.say channel: data.channel, text: msg
      end
    end
  end
end

