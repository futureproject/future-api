module Dreamo
  module Commands
    class Stats < Base

      command "stats"
      triggers "statistics"

      def self.call client, data, match
        client.typing channel: data.channel
        @last_week = Commitment.recent
        WEB_CLIENT.chat_postMessage(
          text: "Student commitments due *last* week:",
          attachments: StatHandler.commitments_by_city(@last_week),
          channel: data.channel,
          as_user: true
        )
        client.typing channel: data.channel
        @next_week = Commitment.upcoming
        WEB_CLIENT.chat_postMessage(
          text: "Student commitments due *this* week:",
          attachments: StatHandler.commitments_by_city(@next_week),
          channel: data.channel,
          as_user: true
        )
      end

    end
  end
end
