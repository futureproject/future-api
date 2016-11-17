class ProfilesController < ApplicationController

  get "/possibility_profiles/:id" do
    authenticate!
    @profile = PossibilityProfile.find(params[:id])
    erb :"profiles/possibility_profile", layout: :"layouts/students"
  end

  # handle incoming requests from typeform
  post "/possibility_profiles" do
    attrs = TypeformClient.parse_for_airtable(params)
    if attrs && @profile = PossibilityProfile.create(attrs)
      # calculate scores
      @profile.score
      # email student
      @profile.deliver_by_email
      status 200
    else
      status 406
    end
  end

end
