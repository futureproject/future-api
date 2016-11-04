module Dreamo
  module Commands
    class Stats < Base

      command "stats"
      triggers "statistics"

      def self.call client, data, match
        client.typing channel: data.channel
        @last_week = Commitment.recent
        @index = 0
        WEB_CLIENT.chat_postMessage(
          text: "Last week's student commitments:",
          attachments: @last_week.group_by{|x| x.school_tfpid.split("-").first }.map{|city, records|
            count_completed = records.select{|x| x.is_complete? }.count
            count_overdue = records.count - count_completed
            color = COLORS[@index % COLORS.count]
            @index += 1
            {
              title: city,
              text: "Students had *#{records.count}* commitments due.\n #{count_completed} got completed\n#{count_overdue} are overdue",
              color: color,
              fallback: city
            }
          },
          channel: data.channel,
          as_user: true
        )
        client.typing channel: data.channel
        @next_week = Commitment.upcoming
        @index = 0
        if @next_week.size < @last_week.size
          business = "less busy"
        elsif @next_week.size > @last_week.size
          business = "busier"
        else
          business = "just as busy"
        end
        WEB_CLIENT.chat_postMessage(
          text: "Next week looks #{business}:",
          attachments: @next_week.group_by{|x| x.school_tfpid.split("-").first }.map{|city, records|
            count_completed = records.select{|x| x.is_complete? }.count
            count_overdue = records.count - count_completed
            color = COLORS[@index % COLORS.count]
            @index += 1
            {
              title: city,
              text: "Students have *#{records.count}* commitments due. \n #{count_completed} are already complete\n#{count_overdue} left to do",
              color: color,
              fallback: city
            }
          },
          channel: data.channel,
          as_user: true
        )
      end

    end
  end
end
