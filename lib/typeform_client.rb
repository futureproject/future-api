module TypeformClient
  include HTTParty

  @@base_uri = 'https://api.typeform.com/v1/form'
  @@api_key = ENV['TYPEFORM_API_KEY']

  # get all the possibility profiles from typeform
  def self.possibility_profiles
    HTTParty.get("#{@@base_uri}/WLMedf?key=#{@@api_key}")
  end

  # import everything into airtable
  def self.import_all
    destination = Airmodel.client.table("app8PZoqiK1HF4xAD", "Results")
    surveys = self.possibility_profiles
    questions = {}
    surveys["questions"].each{|q| questions[q["id"]] = q["question"] }
    responses = surveys["responses"].select{|s| s["completed"] == "1" }
    responses.each_with_index do |response, index|
      r = Airtable::Record.new
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
      destination.create(r)
    end
  end

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
          answer["choices"]["labels"].join("|")
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
