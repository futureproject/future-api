module NamelyClient
  @@client = Namely::Connection.new(
    access_token: ENV["NAMELY_API_TOKEN"],
    subdomain: "dream"
  )

  def self.client
    @@client
  end

  def self.employees
    client.profiles.all
  end

  def self.find_employee(id)
    client.profiles.find(id)
  end

end

