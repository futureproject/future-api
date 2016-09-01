module Dreamo
  module Commands
    class Commitments < Base

      triggers "commitments", "tasks"

      def self.call client, data, match
        client.typing channel: data.channel
        response = Task.undone_for_user(data.user)
        client.say channel: data.channel, text: response
      end
    end
  end
end

