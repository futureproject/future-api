module Dreamo
  module Commands
    class Status < Base

      command "status"
      triggers "commitments", "tasks"
      match /is (?<expression><@\S*>) (?<action>working|doing)/i

      def self.call client, data, match
        client.typing channel: data.channel
        tfpid = match[:expression] ? match[:expression].match(/<@(\w*)>/)[1] : data.user
        tasks = Task.undone_for_user(tfpid)
        if tasks.any?
          msg = tasks.map{|t| "*#{t['By When']}* - #{t['Commitment']}"}.join("\n")
        else
          msg = "Nothing doing"
        end
        client.say channel: data.channel, text: msg
      end

    end
  end
end
