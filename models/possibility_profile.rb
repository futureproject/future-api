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

  # find a record, make sure it has been processed, then return it
  # if it hasn't been processed, process it first,
  # using our SCIENTIFIC GROUPINGS to write a string
  # that represents a student's strongest attribute in each field
  def self.find_and_score(record_id)
    profile = PossibilityProfile.find(record_id)
    # return if this profile already has the three scores
    return profile if (profile["Power Strength"].present?)

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
      "Power Strength": self.calculate_strengths(power_scores),
      "Passion & Purpose Strength": self.calculate_strengths(passion_scores),
      "Possibility Strength": self.calculate_strengths(possibility_scores)
    }

    PossibilityProfile.patch(updated_attrs)

    # update these columns on the returned record
    # can't just set them and save, because Airtable's API breaks
    # w/r/t bases that have formula fields defined
    updated_attrs.each do |k,v|
      profile[k.to_s] = v
    end

    profile
  end

  def self.calculate_strengths(attrs)
    max = attrs.values.max
    strengths = attrs.select{|k,v| v == max}.keys.map{|k| k.gsub("_score","").humanize.titleize }.join(", ")
    strengths
  end

  def self.profile_in(strengths)
    strength_names = strengths.split(",").map(&:strip)
    strength_data = []
    strength_names.each do |strength_name|
      strength_data << App.cache.fetch("strength_info_#{strength_name}", 31536000) {
        at("appYExpmKDFmpgt3j", "Profile").records(
          filterByFormula: "{Name} = '#{strength_name}'",
          limit: 1
        ).first
      }
    end
    strength_data
  end

  def self.strengths_for(record)
    [
      { name: "Power Strength", strengths: self.profile_in(record["Power Strength"]) },
      { name: "Passion & Purpose Strength", strengths: self.profile_in(record["Passion & Purpose Strength"]) },
      { name: "Possibility Strength", strengths: self.profile_in(record["Possibility Strength"]) },
    ]
  end

end

