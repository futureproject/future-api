class TypeformController < ApplicationController

  # handle incoming requests from typeform
  post "/possibility_profiles" do
    puts params
    attrs = TypeformClient.parse_for_airtable(params)
    if attrs && TestProfile.create(attrs)
      # calculate scores 
      # email student
      status 200
    else
      status 406
    end
  end


end
