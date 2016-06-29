class RegistrationController < ApplicationController

  get "/" do
    #block people who haven't had a registration token set by Oauth
    halt(406) unless session[:registration_token]
    @email = session[:registration_token]
    @slack_user = SlackUser.find_by_email(@email)
    if @slack_user
      @employee = Employee.find_or_create_by_slack_id(@slack_user.id)
      @cities = City.all
      @schools = School.all
      erb :"registration/complete_employee_profile"
    else
      erb :"registration/join_slack_first"
    end
  end

  post "/" do
    if @user ||= Employee.update(employee_params)
      session[:registration_token] = nil
      sign_in @user
      redirect "/"
    else
      "It didn't work"
    end
  end

  get "/join_slack" do
    @email = "dreamo@thefutureproject.org"
    erb :"registration/join_slack_first"
  end

  private
    def employee_params
      Employee.airtable_formatted_hash(params[:employee])
    end

end
