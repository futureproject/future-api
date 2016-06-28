class SlackUser
  @@client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])

  def self.client
    @@client
  end

  def self.all
    client.users_list[:members]
  end

  def self.find(id)
    client.users_info(id)
  end

  def self.find_by_email(email)
    all.select{|u| u[:profile][:email] == email }.first
  end

end
