class TestProfile < Airmodel::Model
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

  # use our SCIENTIFIC GROUPINGS to write a string
  # that represents a student's strongest attribute in each field
  def score

    attrs = self.attributes.dup

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
      "Power Strength": self.class.calculate_strengths(power_scores),
      "Passion & Purpose Strength": self.class.calculate_strengths(passion_scores),
      "Possibility Strength": self.class.calculate_strengths(possibility_scores)
    }

    self.update(updated_attrs)
    self
  end
end
