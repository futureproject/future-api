class Redirect
  extend Airtabled

  # less expensive cache-backed version of Redirect.all
  # only caches for 60 seconds because any found redirects
  # get cached aggressively by rack-cache
  def self.all_cached
    App.cache.fetch("redirects", 60) { all }
  end

  # looks for a shortcut in cache
  def self.find_by_shortcut(shortcut)
    all_cached.find{|r| r[:shortcut] == shortcut }
  end

end
