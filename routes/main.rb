class App < Sinatra::Base
  helpers AuthHelper
  before /^(?!\/(auth))/ do
    authenticate!
  end
  #get "/" do
    #"Hello there."
  #end
end
