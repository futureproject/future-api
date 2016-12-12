module TypeformClient
  include HTTParty

  @@base_uri = 'https://api.typeform.com/v1/form'
  @@api_key = ENV['TYPEFORM_API_KEY']

  # get all the possibility profiles from typeform
  def self.possibility_profiles
    HTTParty.get("#{@@base_uri}/WLMedf?key=#{@@api_key}&completed=true")
  end

  def self.missing_profiles
    responses = possibility_profiles["responses"].select do |s|
      s["answers"]["textfield_34000025"].present?
    end
    imported_profiles = PossibilityProfile.all(
      filterByFormula: "NOT(NOT({What is your email address?}))"
    )
    already_imported = responses.select do |x|
      imported_profiles.find{|y| y["What is your email address?"] == x["answers"]["textfield_34000025"] }
    end
    responses - already_imported
  end

  # import everything into airtable
  def self.import_all
    failed_saves = []
    surveys = self.possibility_profiles
    questions = {}
    surveys["questions"].each{|q| questions[q["id"]] = q["question"] }
    responses = surveys["responses"].select{|s| s["completed"] == "1" }
    responses.each_with_index do |response, index|
      r = PossibilityProfile.new
      response["answers"].each do |key,val|
        attr = self.strip_html(questions[key])
        # if the value is a number, save it as an integer
        # TODO: delete last check after all 158 make it in
        if val.present? && val.to_i.to_s == val && val.to_i <= 10
          r[attr] = val.to_i
        else
          r[attr] = val
        end
      end
      if r.save
        puts "saved #{r['Label']}"
      else
        puts "COULD NOT SAVE #{r['Label']}"
        failed_saves.push r
      end
    end
    puts failed_saves.map{|x| x.language }
  end

  def self.find_by_first_name name
    surveys = self.possibility_profiles
    surveys["responses"].select{|r|
      fname =  r["answers"]["textfield_26540922"]
      fname && fname.include?(name)
    }
  end

  def self.find(token)
    HTTParty.get("#{@@base_uri}/WLMedf?key=#{@@api_key}&token=#{token}")["responses"]
  end

  # import one possibilityprofile into airtable
  def self.import_one(token="ee6838e7d4ac3c380c94b0693eee8740")
    data = HTTParty.get("#{@@base_uri}/WLMedf?key=#{@@api_key}&token=#{token}")
    res = data["responses"].first
    fields = {}
    attrs  = {}
    data["questions"].each{|q| fields[q["id"]] = q["question"] }
    res["answers"].each do |key,val|
      attr = self.strip_html(fields[key])
      if val.present? && val.to_i.to_s == val && val.to_i <= 10
        attrs[attr] = val.to_i
      else
        attrs[attr] = val
      end
    end
    p = PossibilityProfile.create(attrs)
    p.score
    p.deliver_by_email
  end

  # parse an incoming Typeform webhook, format it for airtable
  def self.parse_for_airtable(formdata)
    return nil unless formdata["form_response"]
    fields = formdata["form_response"]["definition"]["fields"].map{|x| {name: self.strip_html(x["title"]), id: x["id"] } }
    formdata["form_response"]["answers"].each do |answer|
      formatted_answer = case answer["type"]
        when "number"
          answer["number"]
        when "choice"
          answer["choice"]["label"]
        when "text"
          answer["text"]
        when "choices"
          answer["choices"]["labels"].join("|") rescue answer["choices"]["other"]
        else
          ""
      end
      fields.find{|x| x[:id] == answer["field"]["id"] }[:response] = formatted_answer
    end
    answers = {}
    fields.each do |field|
      answers[self.strip_html(field[:name])] = field[:response]
    end
    answers
  end

  def self.strip_html(str)
    str.gsub(/<\/?[^>]*>/, "").strip
  end

end
