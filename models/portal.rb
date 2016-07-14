class Portal
  extend Airtabled
  # get the portal links, and cache them for a year
  def self.all_cached
    App.cache.fetch("portals", 31536000) { records(view: "Main View") }
  end
end