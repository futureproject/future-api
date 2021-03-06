class ApiController < ApplicationController

  before do
    authenticate!
  end

  # random quotes
  get "/quotes" do
    #cache_control :public, :'no-cache', :must_revalidate, max_age: 10
    @quotes = airtable("Quotes").all.shuffle.first
    json @quotes
  end

  # Students from multiple Got It bases, optionally filtered by name
  get "/students" do
    @students = Student.search(
      name: params[:q],
      school: current_user.goddamn_school,
      shard: current_user.goddamn_city
    )
    json @students.map(&:attributes)
  end

  # get task assignments from the City Dashboard airtable base
  get "/tasks/assignees" do
    @employees = TaskEmployee.search(
      name: params[:q]
    )
    json @employees.map(&:attributes)
  end

  # make a new commitment
  post "/tasks" do
    @task = Task.new(record_params)
    if @task.save
      App.cache.delete "tasks_undone_for_user_#{current_user.goddamn_tfpid}"
      content_type :json
      status 201
      json @task
    else
      content_type :json
      status 400
      json @task.errors
    end
  end

  # Updates a task with params[:task]
  post "/tasks/:id" do
    if Task.patch(params[:id], record_params)
      App.cache.delete("tasks_undone_for_user_#{current_user.goddamn_tfpid}")
      content_type :json
      status 200
    else
      content_type :json
      status 400
    end
  end

  # make a new commitment
  post "/commitments" do
    @commitment = Commitment.new(record_params)
    if @commitment.save(params[:shard])
      App.cache.delete "student_commitments_#{current_user.cache_key}"
      content_type :json
      status 201
      json @commitment
    else
      content_type :json
      status 400
      json @commitment.errors
    end
  end

  get "/reports/:city_tfpid" do
    @report = GotitReport.new(params[:city_tfpid])
    json @report.stats
  end


  # Updates a student commitment with params[:commitment]
  post "/commitments/:id" do
    if Commitment.patch(params[:id], record_params, params[:shard])
      App.cache.delete("student_commitments_#{current_user.cache_key}")
      content_type :json
      status 200
    else
      content_type :json
      status 400
    end
  end

  private
    def record_params
      airtable_formatted(params[:record])
    end

end
