module Dreamo
  class Bot < SlackRubyBot::Bot

    match(/^(?<bot>\S*).*(?<expression>\b(register|registration)\b)/) do |client, data, match|
      client.say channel: data.channel, text: "Registration unavailable at this time."
    end

  end
end
