module IntegrationHelpers
end

module OmniauthSupport

  def login_with_oauth(service = :google_oauth2)
    visit "/auth/#{service}"
  end

  OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
    provider: "google_oauth2",
    uid: "123456789",
    info: {
        :name => "Bruce Waynce",
        :email => "bruce.wayne@thefutureproject.org",
        :first_name => "Bruce",
        :last_name => "Wayne",
        :image => "https://lh3.googleusercontent.com/url/photo.jpg"
    },
  })
end

RSpec.configure do |config|
  config.include IntegrationHelpers, type: :feature
  OmniAuth.config.test_mode = true
  config.include OmniauthSupport
end

