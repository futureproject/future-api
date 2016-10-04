module Dreamo
  module Commands
    class BoldMoves < Base
      match /bold moves/i

      def self.call client, data, match
        moves = BoldMove.all
        WEB_CLIENT.chat_postMessage(
          text: "FY2017 Bold Moves",
          attachments: moves.each_with_index.map{|m, i|
            {
              title: "#{i + 1} - #{m[:title]}",
              text: m[:description],
              color: "#15c8ff",
              fallback: m[:title]
            }
          },
          channel: data.channel,
          as_user: true
        )
      end

    end
  end
end
