class User
  extend Airtabled
  @@table = airtable(:users)

  def self.table
    @@table
  end

  # expensive API call to airtable for all records
  def self.all
    puts "RUNNING EXPENSIVE QUERY"
    @@table.all
  end

  # less expensive cache-backed version of User.all
  # only caches for 120 seconds, because why not
  def self.all_cached
    App.cache.fetch("users", 120) { all }
  end

  def self.find_by_email(email)
    all_cached.select{|user| user.email == email }.first
  end

  def self.find_by_slack_id(slack_id)
    u = all_cached.select{|user| user[:slack_id] == slack_id }.first
  end

  def self.find_or_create_by_slack_id(slack_id, &block)
    u = self.find_by_slack_id(slack_id) || @@table.create(Airtable::Record.new(slack_id: slack_id))
    block.call(u)
  end

  # pull account list from Slack, store them as Employees in airtable
  def self.sync_slack_and_airtable
    client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
    slack_users = client.users_list
    slack_users[:members].each do |slack_user|
      if (slack_user[:is_bot] == false && slack_user[:name] != "slackbot")
        self.find_or_create_by_slack_id(slack_user[:id]) do |result|
          result["Name"] = slack_user[:profile][:real_name_normalized]
          result["Email"] = slack_user[:profile][:email]
          result["Phone"] = slack_user[:profile][:phone]
          result["Title"] = slack_user[:profile][:title]
          self.table.update result
          puts "updated #{result.email}..."
        end
      end
    end
  end

end

