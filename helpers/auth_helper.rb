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
    session['user'] || ENV["AUTH_HACK"]
  end

  def create_session_via_oauth
    user_info = request.env["omniauth.auth"]["info"]
    if user_info && user_info["email"]
      session["user"] = Array(user_info["email"]).first.downcase
      true
    else
      false
    end
  end

end

