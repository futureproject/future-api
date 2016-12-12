class SlackUser
  #@@client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
  @@base_uri = "https://slack.com/api/users.list?token=#{ENV['SLACK_API_TOKEN']}"

  def self.client
    @@client
  end

  def self.all
    response = Net::HTTP.get_response(URI.parse(@@base_uri))
    JSON.parse(response.body)["members"].map(&:with_indifferent_access)
  end

  def self.find(id, set=self.all)
    begin
      set.find{|u| u['id'] == id}
    rescue Slack::Web::Api::Error
      nil
    end
  end

  def self.find_by_email(email, set=self.all)
    set.find{|u| u['profile']['email'] == email }
  end

end
