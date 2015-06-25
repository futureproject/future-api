class Frank < Sinatra::Base
  use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {}
  end

  get '/auth/:provider/callback' do
    user_info = request.env["omniauth.auth"].info
    session["user"] = Array(user_info.email).first.downcase
    url = session['google-auth-redirect'] || to("/")
    redirect url
  end

  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
  end
  get '/auth/sign_out' do
    session['user'] = nil
    redirect '/'
  end

  module AuthHelpers

    def authenticate!
      unless session['user']
        session['google-auth-redirect'] = request.path
        redirect "/auth/google_oauth2"
      end
    end

  end

  helpers AuthHelpers

end
