class TypeformController < ApplicationController

  # handle incoming requests from typeform
  post "/possibility_profiles" do
    attrs = TypeformClient.parse_for_airtable(params)
    if attrs && @profile = TestProfile.create(attrs)
      # calculate scores 
      @profile.score
      # email student
      Mailer.deliver_possibility_profile(
        email: @profile["What is your email address?"],
        profile_url: "http://go.dream.org/possibility_profiles/#{@profile.id}"
      )
      status 200
    else
      status 406
    end
  end


end
