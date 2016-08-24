class WidgetsController < ApplicationController
  helpers Airtabled

  before do
    authenticate!
  end

  get "/daily_quote" do
    #cache_control :public, :must_revalidate, max_age: 86400
    cache_control :public, :must_revalidate, max_age: 10
    @quote = Quote.daily
    erb :"widgets/daily_quote", layout: false
  end

  get "/tasks" do
    @tasks = Task.undone_for_user(current_user)
    erb :"widgets/tasks", layout: false
  end

  get "/commitments" do
    @commitments = Commitment.undone
    erb :"widgets/commitments", layout: false
  end

  get "/profiles" do
    @profiles = PossibilityProfile.for_user(current_user)
    erb :"widgets/profiles", layout: false
  end

  get "/:widget" do
    erb :"widgets/#{params[:widget]}", layout: false
  end

end
