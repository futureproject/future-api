class ApiController < ApplicationController

  before do
    authenticate!
  end

  get "/quotes" do
    #cache_control :public, :'no-cache', :must_revalidate, max_age: 10
    @quotes = airtable("Quotes").all.shuffle.first
    json @quotes
  end

  get "/students" do
    @students = Student.search(
      name: params[:q],
      school: current_user.goddamn_school,
      shard: current_user.goddamn_city
    )
    json @students.map(&:attributes)
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

  # make a new commitment
  post "/commitments" do
    @commitment = Commitment.new(params[:record])
    puts @commitment
    if @commitment.save
      "it worked"
    else
      erb :"commitments/new", layout: :"layouts/students"
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
