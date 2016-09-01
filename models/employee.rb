class Employee < Airtable::Model

  def self.default_sort
    ["Email", :asc]
  end

  def self.find_or_create_by_slack_id(id, &block)
    u = find_by(slack_id: id) || create(slack_id: id)
    block ? block.call(u) : u
  end

  # look in Memcache for this user
  # if the user isn't in memcache, they haven't passed auth
  # so deny them access
  def self.find_by_auth_token(token)
    e = self.new(tfpid: token)
    App.cache.get(e.cache_key)
  end

  def self.find_by_slack_id(id)
    e = self.new({"TFPID": id})
    App.cache.fetch("slack_user_#{id}", 31536000) {
      self.find_by("slack_id": id)
    }
  end

  # iterate through all the many ways TFPID might be
  # fucking defined on this thing, return the first one that works
  def goddamn_tfpid
    keys = [self["TFPID"], self[:tfpid], self[:TFPID], self["tfpid"]]
    keys.find{|u| !u.nil? }
  end

  def cache_key
    "#{self.class.name.tableize}_#{goddamn_tfpid}"
  end

  # all Tasks assigned to this user in the city dashboard
  def tasks
    Task.undone_for_user(goddamn_tfpid)
  end

  def tasks_cached
    Task.undone_for_user_cached(goddamn_tfpid)
  end

end

