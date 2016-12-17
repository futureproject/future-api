module API
  module V1
    class Controller < ApplicationController

      before do
        authenticate!
      end

      helpers do
        #override session-based auth from ApplicationController
        # use token auth instead
        def current_user
          token = ENV['AUTH_HACK'] || params[:token]
          token ? Employee.find_by_auth_token(token) : nil
        end
      end
    end
  end
end

Dir["#{File.dirname(__FILE__)}/v1/*.rb"].each{|f| require f }
