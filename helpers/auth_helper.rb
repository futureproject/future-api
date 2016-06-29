module AuthHelper

  def authenticate!
    if current_user
      true
    else
      session['google-auth-redirect'] = request.path
      redirect "/auth/google_oauth2"
    end
  end

  def current_user
    token = session[:auth_token] || ENV["AUTH_HACK"]
    token ? Employee.find_by_auth_token(token) : nil
  end

  def create_session_via_oauth
    email = get_email_from_auth_hash
    user = Employee.find_by(email: email)
    if email && user
      sign_in user
      true
    else
      false
    end
  end

  def sign_in user
    App.cache.set(Employee.cache_key_for(user), user)
    session[:auth_token] = user[:slack_id]
  end

  def sign_out user
    App.cache.delete Employee.cache_key_for(user)
    session[:auth_token] = nil
  end

  def get_email_from_auth_hash(hash=request.env["omniauth.auth"]["info"])
    if hash["email"]
      Array(hash["email"]).first.to_s.downcase
    else
      nil
    end
  end

end

