class RegistrationController < ApplicationController

  get "/" do
    @email = session[:registration_token]
    halt(406) unless @email
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

  private
    def employee_params
      Employee.airtable_formatted_hash(params[:employee])
    end

end
