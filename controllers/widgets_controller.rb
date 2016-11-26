class WidgetsController < ApplicationController
  helpers AsyncHelper

  before do
    authenticate!
  end

  get "/daily_quote" do
    #cache_control :public, :must_revalidate, max_age: 86400
    #cache_control :public, :must_revalidate, max_age: 10
    asynchronously(content_type: 'text/html') do
      @quote = Quote.daily
      erb :"widgets/daily_quote", layout: false
    end
  end

  get "/tasks" do
    asynchronously(:content_type => 'text/html') do
      @tasks = current_user.tasks_cached
      erb :"widgets/tasks", layout: false
    end
  end

  get "/commitments" do
    #cache_control :public, :must_revalidate, max_age: 30
    asynchronously(:content_type => 'text/html') do
      @commitments = current_user.student_commitments.sort_by{|x| x["By When"] }
      erb(:"widgets/commitments", layout: false)
    end
  end

  get "/profiles" do
    asynchronously(:content_type => 'text/html') do
      @profiles = PossibilityProfile.for_user(current_user)
      erb(:"widgets/profiles", layout: false)
    end
  end

  get "/:widget" do
    erb(:"widgets/#{params[:widget]}", layout: false)
  end

end
