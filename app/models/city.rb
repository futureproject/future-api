class City < Airmodel::Model

  def self.default_sort
    ["Name", :asc]
  end

  def self.all_cached
    App.cache.fetch("cities", 31536000) { all }
  end

end
