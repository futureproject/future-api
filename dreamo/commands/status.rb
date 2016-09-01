module Dreamo
  module Commands
    class Status < Base

      command "status"
      triggers "commitments", "tasks"

      match /is (?<expression><@\S*>) (?<action>working|doing)/i
      match /(update|status) (?<expression><@\S*>)/i

      def self.call client, data, match
        client.typing channel: data.channel
        tfpid = match[:expression] ? match[:expression].match(/<@(\w*)>/)[1] : data.user
        employee = Employee.find_by_slack_id(tfpid)
        if !employee
          msg = "I couldn't find anyone with that username."
          client.say channel: data.channel, text: msg
        else
          tasks = employee.tasks.first(20)
          if tasks.length == 0
            header = "#{employee["Name"]} has done all the things."
          elsif tasks.length == 1
            header = "#{employee["Name"]} is working on one thing."
          else
            header = "#{employee["Name"]} is working on #{tasks.count} things."
          end
          WEB_CLIENT.chat_postMessage(
            text: header,
            attachments: tasks.map{|t|
              {
                title: t["Commitment"],
                text: Date.parse(t["By When"]).strftime("%b %d"),
                color: "#15c8ff",
                #pretext: t["By When"],
                fallback: t["Commitment"]
              }
            },
            channel: data.channel,
            as_user: true
          )
        end
      end

    end
  end
end
