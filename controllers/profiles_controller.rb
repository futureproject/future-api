class ProfilesController < ApplicationController

  before do
    authenticate!
  end

  get "/possibility_profiles/:id" do
    @profile = PossibilityProfile.find_and_score(params[:id])
    erb :"profiles/possibility_profile", layout: :"layouts/students"
  end

end
