class ApiController < ApplicationController
  helpers Airtabled

  before do
    authenticate!
  end

  get "/quotes" do
    #cache_control :public, :'no-cache', :must_revalidate, max_age: 10
    @quotes = airtable("Quotes").all.shuffle.first
    json @quotes
  end

  # Take a task, toggle whether it's done or not
  post "/tasks/:id/toggle" do
    @task = Task.find(params[:id])
    toggle = @task["Complete?"].to_s.empty? ? true : false
    Task.patch({id: @task.id, "Complete?": toggle})
    App.cache.delete("tasks_for_user_#{current_user.email}")
    json @task
  end

end
