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
    user_id = generate_user_id_from_auth_hash(request.env["omniauth.auth"]["info"])
    if user_id
      session["user"] = user_id
      true
    else
      false
    end
  end

  private
    def generate_user_id_from_auth_hash(hash)
      if hash["email"]
        Array(hash["email"]).first.to_s.downcase
      else
        nil
      end
    end

end

