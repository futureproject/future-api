class RegistrationController < ApplicationController
  helpers RegistrationHelper

  get "/" do
    @auth_info = get_auth_info_from_registration_token

    if @auth_info[:slack_user]
      @employee = Employee.find_or_create_by_slack_id(@auth_info[:slack_user][:id])
      @cities = City.all
      @schools = School.all
      erb :"registration/complete_employee_profile"
    else
      erb :"registration/join_slack_first"
    end
  end

  post "/" do
    if @user ||= Employee.patch(params[:employee].delete("id"), params[:employee])
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

  post "/link_slack_account" do
    session[:registration_token] = params[:slack_id]
    redirect "/registration/"
  end

end
