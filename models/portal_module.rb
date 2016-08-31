class PortalModule < Airtable::Model

  # call the Main View, so position is respected
  def self.all
    records(view: "Main View")
  end

  # get the portal links, and cache them for a year
  def self.all_cached
    App.cache.fetch("portal_modules", 31536000) { all }
  end
end
