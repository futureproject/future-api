class Redirect
  extend Airtabled
  @@table = airtable("Redirects")

  # expensive API call to airtable for all records
  # caches response for an hour
  def self.all
    puts "RUNNING EXPENSIVE QUERY"
    records = @@table.all
    App.cache.set("redirects", records, 3600)
    records
  end

  # inexpensive cache-backed version of all
  def self.all_cached
    App.cache.fetch("redirects", 3600) { all }
  end

  # looks for a shortcut in cache, then falls back to an API call
  def self.find_by_shortcut(shortcut)
    all_cached.find{|r| r[:shortcut] == shortcut } || all.find {|r| r[:shortcut] == shortcut }
  end

end
