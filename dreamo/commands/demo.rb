module Dreamo
  module Commands
    class Demo < SlackRubyBot::Commands::Base
      match /ready for a demo/i

      def self.call client, data, match
        msg = "Ready, <@#{data.user}>. I think."
        client.say channel: data.channel, text: msg
      end

    end
  end
end
