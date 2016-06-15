class ApplicationController < App

  get "/" do
    authenticate!
    @quote = Quote.daily
    erb :"application/home"
  end

  get '/:shortcut' do
    @redirect = Redirect.find_by_shortcut(params[:shortcut])
    url = @redirect ? @redirect.url : settings.default_redirect
    redirect url
  end

end
