class WidgetsController < ApplicationController
  helpers Airtabled

  before do
    authenticate!
  end

  get "/daily_quote" do
    cache_control :public, :must_revalidate, max_age: 86400
    @quote = Quote.daily
    erb :"widgets/daily_quote", layout: false
  end

  get "/tasks" do
    @commitments = Commitment.undone_for_user_cached(current_user)
  end

end
