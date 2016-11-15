class Employee < Airmodel::Model

  # get all records, cache them for 24 hours
  def self.all_cached
    App.cache.fetch("employees", 86400) { all }
  end

  def self.default_sort
    ["Email", :asc]
  end

  def self.find_or_create_by_slack_id(id, &block)
    u = find_by(slack_id: id) || create(slack_id: id)
    block ? block.call(u) : u
  end

  def self.search(args)
    filters = []
    filters.push ["FIND('#{args[:name].downcase}', LOWER(NAME)) > 0"] if args[:name]
    some(
      sort: ["NAME", :asc],
      filterByFormula: "AND(#{filters.join(',')})"
    )
  end


  # look in Memcache for this user
  # if the user isn't in memcache, they haven't passed auth
  # so deny them access
  def self.find_by_auth_token(token)
    e = self.new(tfpid: token)
    App.cache.get(e.cache_key)
  end

  def self.find_by_slack_id(id)
    App.cache.fetch("slack_user_#{id}", 31536000) {
      self.find_by("slack_id": id)
    }
  end

  def cache_key
    "#{self.class.table_name}_#{goddamn_tfpid}"
  end

  # all Tasks assigned to this user in the city dashboard
  def tasks
    Task.undone_for_user(goddamn_tfpid)
  end

  def tasks_cached
    Task.undone_for_user_cached(goddamn_tfpid)
  end

  # students relevant to this user
  def students
    filters = []
    filters.push("{SCHOOL_TFPID} = '#{goddamn_school}'") if goddamn_school
    Student.some(
      shard: self.goddamn_city,
      sort: ["Name", :asc],
      filterByFormula: "AND(#{filters.join(',')})"
    )
  end

  # upcoming commitments relevant to this user
  def student_commitments
    shard_id = goddamn_city == "HQ" ? nil : goddamn_city
    App.cache.fetch("student_commitments_#{self.cache_key}", 86400) {
      filters = ["{By When} > '#{Date.today - 1.week}'", "NOT({Complete?})", "NOT(NOT({WHO}))"]
      filters.push("{SCHOOL_TFPID} = '#{goddamn_school}'") if goddamn_school
      Commitment.some(
        shard: shard_id,
        sort: ["By When", :asc],
        filterByFormula: "AND(#{filters.join(',')})"
      )
    }
  end

  def dashboard_modules
    if self["admin"].present?
      PortalModule.all_cached
    else
      PortalModule.cached_for_team(self.goddamn_city)
    end
  end

end

