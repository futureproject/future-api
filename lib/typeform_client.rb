module TypeformClient
  include HTTParty

  @@base_uri = 'https://api.typeform.com/v1/form'
  @@api_key = ENV['TYPEFORM_API_KEY']

  def self.possibility_profiles
    HTTParty.get("#{@@base_uri}/WLMedf?key=#{@@api_key}")
  end

end
