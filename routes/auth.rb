class App < Sinatra::Base

  get '/auth/:provider/callback' do
    if create_session_via_oauth
      url = session['google-auth-redirect'] || "/"
      redirect url
    else
      "Auth error"
    end
  end

  get '/auth/failure' do
    content_type 'text/plain'
    request.env['omniauth.auth'].to_s || "No data"
  end

  get '/auth/log_out' do
    session.clear
    "You are now logged out."
  end

end

