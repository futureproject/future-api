module Dreamo
  module Commands
    class Commitments < Base

      triggers "commitments", "tasks"

      def self.call client, data, match
        msg = "You're currently 100% commitment-free."
        client.say channel: data.channel, text: msg
      end
    end
  end
end

