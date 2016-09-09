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
    if Task.patch(params[:id], params[:record])
      App.cache.delete("tasks_undone_for_user_#{current_user["TFPID"]}")
      content_type :json
      status 200
    else
      content_type :json
      status 400
    end
  end

  # Updates a student commitment with params[:commitment]
  post "/commitments/:id" do
    if Commitment.patch(params[:id], params[:record], params[:shard])
      App.cache.delete("student_commitments_#{current_user.cache_key}")
      content_type :json
      status 200
    else
      content_type :json
      status 400
    end
  end

end
