class Commitment < Airmodel::Model

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

end
