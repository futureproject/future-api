module Dreamo
  module Commands
    class Status < Base

      command "status"
      match /is (?<expression><@\S*>) (?<action>working|doing)/i

      def self.call client, data, match
        username = match[:expression] || "<@#{data.user}>"
        msg = "#{username} isn't working on anything."
        client.say channel: data.channel, text: msg
      end

    end
  end
end
