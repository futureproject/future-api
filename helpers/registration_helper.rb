module RegistrationHelper

  def get_auth_info_from_registration_token
    token = session[:registration_token]

    #block people who haven't had a registration token set by Oauth
    halt 401 unless token

    slackers = SlackUser.all

    case
    # if the token is an email address
    when token.match(/@/) && user ||= SlackUser.find_by_email(token, slackers)
      { slack_user: user }
    # otherwise if there's a match by Slack ID
    when user ||= SlackUser.find(token)
      { slack_user: user[:user] }
    # fuck it, just return all the users
    else
      { slackers: slackers }
    end
  end

end
