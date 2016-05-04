use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_KEY'],
    ENV['GOOGLE_SECRET'],
    { hd: 'thefutureproject.org', access_type: 'online' }
end

get '/auth/:provider/callback' do
  user_info = request.env["omniauth.auth"].info
  session["user"] = Array(user_info.email).first.downcase
  url = session['google-auth-redirect'] || to("/")
  redirect url
end

get '/auth/failure' do
  content_type 'text/plain'
  request.env['omniauth.auth'].to_s || "No data"
end
get '/auth/sign_out' do
  session['user'] = nil
  "You are now logged out."
end

module AuthHelpers

  def authenticate!
    if current_user
      true
    else
      session['google-auth-redirect'] = request.path
      redirect "/auth/google_oauth2"
    end
  end

  def current_user
    session['user'] || ENV["AUTH_HACK"]
  end

end

helpers AuthHelpers

