class Task < Airmodel::Model

  def self.all_cached
    App.cache.fetch("tasks", 3600) {
      some(sort: ["By When", :asc])
    }
  end

  def self.undone
    some(
      filterByFormula: "NOT({Complete?})",
      sort: ["By When", :asc]
    )
  end

  def self.undone_for_user(tfpid)
    some(
      filterByFormula: "AND(NOT({Complete?}),{TFPID} = '#{tfpid}')",
      sort: ["By When", :asc]
    )
  end

  def self.undone_for_user_cached(tfpid)
    key = "tasks_undone_for_user_#{tfpid}"
    App.cache.fetch(key, 3600) { undone_for_user(tfpid) }
  end

  def required_fields
    ["Commitment", "Who", "By When"]
  end

  def valid?
    !required_fields.find{|x| self[x].blank? }
  end

  def errors
    "Error! Please fill in who, what, and when"
  end

end

