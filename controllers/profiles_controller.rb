class ProfilesController < ApplicationController

  before do
    authenticate!
  end

  get "/possibility_profiles/:id" do
    @profile = PossibilityProfile.find_and_score(params[:id])
    erb :"profiles/possibility_profile", layout: :"layouts/students"
  end

  # handle incoming requests from typeform
  post "/possibility_profiles" do
    attrs = TypeformClient.parse_for_airtable(params)
    @profile = TestProfile.new(attrs)
    if @profile.save
      status 200
    else
      status 406
    end
  end


end
