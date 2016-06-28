class Employee
  extend Airtabled
  @@table = airtable(:employees)

  def self.all
    @@table.all(sort: ["Name", :asc])
  end

  def self.find_or_create_by_slack_id(id, &block)
    u = find_by(slack_id: id) || @@table.create(Airtable::Record.new(slack_id: id))
    block ? block.call(u) : u
  end
end

