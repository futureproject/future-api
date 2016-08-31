class ApiController < ApplicationController

  before do
    authenticate!
  end

  get "/quotes" do
    #cache_control :public, :'no-cache', :must_revalidate, max_age: 10
    @quotes = airtable("Quotes").all.shuffle.first
    json @quotes
  end

  # Updates a task with params[:task]
  post "/tasks/:id" do
    if Task.patch(params[:id], params[:task])
      App.cache.delete("tasks_for_user_#{current_user.email}")
    else
      content_type :json
      status 400
    end
  end

end
