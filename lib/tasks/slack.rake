namespace :slack do
  desc "Sync slack users to airtable"
  task sync_users: :environment do
    puts "Syncing slack users to airtable"
    require "slack-ruby-client"
    client = Slack::Web::Client.new
  end
end
