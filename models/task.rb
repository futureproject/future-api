class Task
  extend Airtabled

  def self.all_cached
    App.cache.fetch("tasks", 3600) {
      records(sort: ["By When", :asc])
    }
  end

  def self.undone
    records(
      filterByFormula: "NOT({Complete}?)",
      sort: ["By When", :asc]
    )
  end

  def self.for_user(user)
    App.cache.fetch("tasks_for_user_#{user.email}", 60) {
      records(
        filterByFormula: "NOT({Complete}?)",
        sort: ["By When", :asc]
      )
    }
  end

end

