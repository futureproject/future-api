class ApplicationController < App
  helpers AuthHelper
  helpers AppHelper
  #helpers AsyncHelper

  get "/" do
    authenticate!
    @portal_modules = current_user.portal_modules
    erb :"application/dashboard"
  end

  get "/error_tracking" do
    raise "You broke it!"
  end

  get '/expensive_test' do
    @tasks = Task.some
    json @tasks.to_json
  end

  get '/less_expensive_test' do
    @tasks = Task.all_cached
    json @tasks.to_json
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
