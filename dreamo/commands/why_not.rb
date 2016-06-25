module Dreamo
  module Commands
    class WhyNot < Base

      match /\b(why not)\b/i

      def self.call client, data, match
        msg = "There are those that look at things the way they are, and ask _why_? I dream of things that never were, and ask _why not_?"
        client.say channel: data.channel, text: msg
      end

    end
  end
end
