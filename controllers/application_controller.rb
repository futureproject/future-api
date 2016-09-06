class ApplicationController < App
  helpers AuthHelper
  helpers AppHelper

  get "/" do
    authenticate!
    @portal_modules = current_user.dashboard_modules
    erb :"application/dashboard"
  end

  get '/:shortcut' do
    @redirect = Redirect.find_by_shortcut(params[:shortcut])
    if @redirect
      cache_control :public, :must_revalidate, max_age: 86400
      redirect @redirect.url
    else
      redirect settings.default_redirect
    end
  end

end
