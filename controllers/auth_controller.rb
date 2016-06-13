class AuthController < ApplicationController

  configure do
    use OmniAuth::Builder do
      # set omniauth path prefix to root, because this controller
      # is already mounted at "/auth"
      configure do |config|
        config.path_prefix = ""
      end
      # add TFP's google apps account as the only provider
      provider :google_oauth2,
        ENV['GOOGLE_KEY'],
        ENV['GOOGLE_SECRET'],
        { hd: 'thefutureproject.org', access_type: 'online' }
    end
  end

  get '/:provider/callback' do
    if create_session_via_oauth #this is an AuthHelper method
      url = session['google-auth-redirect'] || "/"
      redirect url
    else
      "Auth error"
    end
  end

  get '/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_s || "No data"
  end

  get '/log_out' do
    session.clear
    erb :"auth/goodbye"
  end

end

