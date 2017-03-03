module FormManager
  @@forms = YAML.load_file("#{App.root}/config/db/forms.yml")

  def self.forms_for(user)
    return nil if (!user.goddamn_city || user.goddamn_city.match(/hq/i))
    forms = {}
    @@forms.each do |key, value|
      forms[key] = value[user.goddamn_city]
    end
    forms
  end

end
