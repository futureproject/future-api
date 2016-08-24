module Dreamo
  class Bot < SlackRubyBot::Bot

    # listen for Airtable pings re: new Possibility Profiles
    # calculate their cumulative scores
    match /possibility profile data/i do |client, data, match|
      if data[:bot_id] == "B24JU1HMF" && data[:attachments]
        data[:attachments].each do |attachment|
          record_id = attachment[:title_link].split("/").last
          PossibilityProfile.calculate_scores(record_id)
        end
      end
    end

  end
end
