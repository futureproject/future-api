class SlackUser
  @@client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])

  def self.client
    @@client
  end

  def self.all
    client.users_list[:members]
  end

  def self.find(id)
    begin
      client.users_info(user: id)
    rescue Slack::Web::Api::Error
      nil
    end
  end

  def self.find_by_email(email, set=self.all)
    set.select{|u| u[:profile][:email] == email }.first
  end

end
