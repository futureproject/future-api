class ApplicationController < App
  helpers AuthHelper

  get "/" do
    erb :"application/home"
  end

  get '/:shortcut' do
    @redirect = params[:shortcut] ? Redirect.find(shortcut: params[:shortcut]) : nil
    if @redirect
      redirect @redirect.url
    else
      redirect settings.default_redirect
    end
  end

end

