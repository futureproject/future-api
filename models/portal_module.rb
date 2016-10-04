class PortalModule < Airtable::Model

  # call the Main View, so position is respected
  def self.all
    records(view: "Main View")
  end

  # get the portal links, and cache them for a year
  def self.all_cached
    App.cache.fetch("portal_modules", 31536000) { all }
  end

  def self.cached_for_team(team)
    cities = DB[:employees].keys
    team = cities.include?(team) ? "City" : "HQ"
    App.cache.fetch("portal_modules_#{team}", 31536000) {
      records(view: "Main View").select{|rec|
        rec["Audience"].include? team
      }
    }
  end
end
