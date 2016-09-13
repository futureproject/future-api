class Commitment < Airtable::Model

  def goddamn_city
    goddamn_school.try(:split, "-").try(:first)
  end

end
