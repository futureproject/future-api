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
    #@commitments = Commitment.undone_for_user_cached(current_user)
    erb :"widgets/tasks", layout: false
  end

  get "/commitments" do
    @commitments = Commitment.all_cached
    erb :"widgets/commitments", layout: false
  end

  get "/library" do
    erb :"widgets/library", layout: false
  end

  get "/swag" do
    erb :"widgets/library", layout: false
  end

end
