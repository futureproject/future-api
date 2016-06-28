namespace :slack do
  desc "Sync slack users to airtable"
  task sync_users: :environment do
    puts "Syncing slack users to airtable Employee database"
    Employee.sync_slack_and_airtable
  end
end
