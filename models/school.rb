class School
  extend Airtabled

  def self.default_sort
    ["Label", :asc]
  end

  def self.all_cached
    App.cache.fetch("schools", 86400) { all }
  end

  def all
    all(view: "Active")
  end

end
