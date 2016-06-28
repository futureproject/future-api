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
    registered_employee = Employee.find_by_email(email)
    if email && registered_employee
      session[:auth_token] = registered_employee.slack_id
      true
    else
      false
    end
  end

  def get_email_from_auth_hash(hash=request.env["omniauth.auth"]["info"])
    if hash["email"]
      Array(hash["email"]).first.to_s.downcase
    else
      nil
    end
  end

end

