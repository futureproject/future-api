class City
  extend Airtabled

  def self.default_sort
    ["Name", :asc]
  end

  def self.all_cached
    App.cache.fetch("cities", 86400) { all }
  end
end
