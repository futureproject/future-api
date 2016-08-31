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

  def self.undone_for_user(user)
    App.cache.fetch("tasks_for_user_#{user.email}", 3600) {
      records(
        filterByFormula: "AND(NOT({Complete?}),{TFPID} = '#{user["TFPID"]}')",
        sort: ["By When", :asc],
        limit: 100
      )
    }
  end

end

