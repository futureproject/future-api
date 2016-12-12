class School < Airmodel::Model

  def self.default_sort
    ["Label", :asc]
  end

  def self.all_cached
    App.cache.fetch("schools", 86400) { all }
  end

  def self.all
    some(view: "Active")
  end


end
