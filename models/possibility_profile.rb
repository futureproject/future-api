class PossibilityProfile
  extend Airtabled

  def self.for_place(tfpid)
    records(
      filterByFormula: "FIND('#{tfpid}', {School})",
      limit: 100,
      sort: ["Name", :asc]
    )
  end

  def self.for_user(user)
    if user["SCHOOL_TFPID"]
      self.for_place(user["SCHOOL_TFPID"])
    elsif user["CITY_TFPID"]
      self.for_place(user["CITY_TFPID"])
    else
      self.records
    end
  end

  # using our SCIENTIFIC GROUPINGS, write a string
  # that represents a student's strongest attribute in each field
  def self.calculate_scores(record_id)
    profile = PossibilityProfile.find(record_id)
    # return if this profile already has the three scores
    return true if (profile["CF Power Strength"].present?)

    attrs = profile.attributes.dup

    # calculate POWER strength
    power_scores = attrs.extract!(
      :competence_score,
      :personal_growth_score,
      :self_acceptance_score
    )
    passion_scores = attrs.extract!(
      :autonomy_score,
      :spark_score,
      :purpose_score
    )
    possibility_scores = attrs.extract!(
      :optimism_score,
      :hope_score,
      :connection_score
    )

    updated_attrs = {
      id: attrs[:id],
      "CF Power Strength": self.find_strengths(power_scores),
      "CF Passion Strength": self.find_strengths(passion_scores),
      "CF Possibility Strength": self.find_strengths(possibility_scores)
    }
    PossibilityProfile.patch(updated_attrs)
  end

  def self.find_strengths(attrs)
    max = attrs.values.max
    strengths = attrs.select{|k,v| v == max}.keys.map{|k| k.gsub("_score","").humanize.titleize }.join(", ")
    strengths
  end

end

