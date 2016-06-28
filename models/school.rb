class School
  extend Airtabled
  @@table = airtable(:schools)

  def self.all
    @@table.all(sort: ["Label", :asc])
  end

  def self.all_cached
    App.cache.fetch("schools", 86400) { all }
  end

end
