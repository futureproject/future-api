class City
  extend Airtabled
  @@table = airtable(:cities)

  def self.all
    @@table.all(sort: ["Name", :asc])
  end

  def self.all_cached
    App.cache.fetch("cities", 86400) { all }
  end
end
