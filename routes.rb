class Frank < Sinatra::Application

  get '/' do
    haml :welcome
  end

end
