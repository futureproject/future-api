class PortalModule < Airmodel::Model

  # call the Main View, so position is respected
  def self.all
    some(view: "Main View")
  end

  # get the portal links, and cache them for a year
  def self.all_cached
    App.cache.fetch("portal_modules", 31536000) { all }
  end

  def self.cached_for_team(team)
    cities = City.all_cached.map(&:tfpid)
    team = cities.include?(team) ? "City" : "HQ"
    App.cache.fetch("portal_modules_#{team}", 31536000) {
      some(view: "Main View").select{|rec|
        rec["Audience"].include? team
      }
    }
  end
end
