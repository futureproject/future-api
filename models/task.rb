class Task < Airtable::Model

  def self.all_cached
    App.cache.fetch("tasks", 3600) {
      records(sort: ["By When", :asc])
    }
  end

  def self.undone
    records(
      filterByFormula: "NOT({Complete?})",
      sort: ["By When", :asc],
      limit: 100
    )
  end

  def self.undone_for_user(tfpid)
    records(
      filterByFormula: "AND(NOT({Complete?}),{TFPID} = '#{tfpid}')",
      sort: ["By When", :asc],
      limit: 100
    )
  end

  def self.undone_for_user_cached(tfpid)
    key = "tasks_undone_for_user_#{tfpid}"
    App.cache.fetch(key, 3600) { undone_for_user(tfpid) }
  end

end

