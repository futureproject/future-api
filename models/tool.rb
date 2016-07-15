class Tool
  extend Airtabled
  # get the portal links, and cache them for a year
  def self.all_cached
    App.cache.fetch("tools", 31536000) { records(view: "Main View") }
  end
end
