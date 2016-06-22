module Dreamo
  class Bot < SlackRubyBot::Bot
    match /[^\S*](register|registration).*?/i do |client, data, match|
      client.say channel: data.channel, text: "Registration unavailable at this time."
    end
  end
end
