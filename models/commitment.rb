class Commitment < Airmodel::Model

  def self.recent
    App.cache.fetch("global_recent_commitments", 86400) {
      filters = ["{By When} <= '#{Date.today}'", "{By When} >= '#{Date.today-1.weeks}'", "NOT(NOT({SCHOOL_TFPID}))"]
      self.some(
        filterByFormula: "AND(#{filters.join(',')})",
        sort: ["By When", :asc]
      )
    }
  end

  def self.upcoming
    App.cache.fetch("global_upcoming_commitments", 86400) {
      filters = ["{By When} > '#{Date.today}'", "{By When} <= '#{Date.today+1.weeks}'", "NOT(NOT({SCHOOL_TFPID}))"]
      self.some(
        filterByFormula: "AND(#{filters.join(',')})",
        sort: ["By When", :asc]
      )
    }
  end

  def goddamn_city
    goddamn_school.try(:split, "-").try(:first)
  end

  def required_fields
    ["Commitment", "By Whom", "By When"]
  end

  def valid?
    !required_fields.find{|x| self[x].blank? }
  end

  def errors
    "Error! Please fill in who, what, and when"
  end

  def shard_identifier
    goddamn_city
  end

  def is_complete?
    self["Complete?"].present?
  end

end
