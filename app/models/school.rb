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

  def commitments
    Commitment.all(
      filterByFormula: "{SCHOOL_TFPID}='#{self.tfpid}'"
    )
  end

  def dream_team
    Student.where("SCHOOL_TFPID" => self.tfpid, "Dream Team" => "1")
  end

  def students
    Student.where("SCHOOL_TFPID" => self.tfpid)
  end

end
