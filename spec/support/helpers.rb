module IntegrationHelpers
end

module OmniauthSupport

  def login_with_oauth(service = :google_oauth2)
    visit "/auth/#{service}"
  end

  def disable_automatic_auth
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "123456789",
      info: {}
    })
  end

  def enable_automatic_auth(default_email="chris.frank@thefutureproject.org")
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "123456789",
      info: {
          :name => "Chris Frank",
          :email => default_email,
          :first_name => "Chris",
          :last_name => "Frank",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      },
    })
  end

end

RSpec.configure do |config|
  config.include IntegrationHelpers, type: :feature
  OmniAuth.config.test_mode = true
  config.include OmniauthSupport
end

