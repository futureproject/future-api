class Team
  extend Airtabled

  def self.default_sort
    ["TFPID", :asc]
  end

  def self.all
    records(view: "Main View")
  end

  def self.all_cached
    App.cache.fetch("teams", 86400) { all }
  end
end
