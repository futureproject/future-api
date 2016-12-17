class API::V1::Controller

  get '/cities' do
    @cities = City.all_cached
    json @cities
  end

  get '/cities/:tfpid' do
    @city = City.find_by(tfpid:  params[:tfpid].upcase)
    json @city
  end

end
