class Employee
  extend Airtabled
  @@table = airtable(:employees)

  def self.table
    @@table
  end

  def self.all
    @@table.all(sort: ["Name", :asc])
  end

  def self.find_or_create_by_slack_id(id, &block)
    u = find_by(slack_id: id) || @@table.create(Airtable::Record.new(slack_id: id))
    block ? block.call(u) : u
  end

  def self.update(attrs)
    record = find(attrs[:id])
    attrs.each { |k,v| record[k] = v }
    if @@table.update(record)
      record
    else
      false
    end
  end

  def self.find_by_auth_token(token)
    App.cache.get cache_key_for({slack_id: token})
  end

  def self.cache_key_for(employee)
    "employee_#{employee[:slack_id]}"
  end

end

