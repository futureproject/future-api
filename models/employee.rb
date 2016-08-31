class Employee < Airtable::Model

  def self.default_sort
    ["Email", :asc]
  end

  def self.find_or_create_by_slack_id(id, &block)
    u = find_by(slack_id: id) || create(slack_id: id)
    block ? block.call(u) : u
  end

  def self.find_by_auth_token(token)
    App.cache.get cache_key_for({slack_id: token})
  end

  # TODO 
  # refactor this to an instance method
  def self.cache_key_for(employee)
    "employee_#{employee[:slack_id]}"
  end

end

