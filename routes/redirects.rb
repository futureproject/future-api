class App < Sinatra::Base

  before "/redirects*" do
    authenticate!
  end

  get '/' do
    authenticate!
    @resources = Redirect.all
    erb :"redirects/index"
  end

  get '/redirects' do
    @resources = Redirect.all
    json @resources
  end

  get '/redirects/new' do
    @resource = Redirect.new
    @form_action = "/redirects"
    erb :"redirects/form"
  end

  get '/redirects/:id/edit' do
    set_redirect
    @form_action = "/redirects/#{@resource.id}"
    erb :"redirects/form"
  end

  post '/redirects' do
    @resource = Redirect.new(allowed_params)
    begin
      @resource.save
      redirect '/'
    rescue Sequel::ValidationFailed
      erb :"redirects/form"
    end
  end

  post '/redirects/:id' do
    set_redirect
    begin
      @resource.update allowed_params
      redirect '/'
    rescue Sequel::ValidationFailed
      erb :"redirects/form"
    end
  end

  get '/redirects/:id/destroy' do
    @resource = Redirect.find(id: params[:id])
    @resource.delete
    redirect '/'
  end

  get '/:shortcut' do
    url = Redirect.find(shortcut: params[:shortcut]).url rescue settings.default_redirect
    redirect url
  end

  private
    def set_redirect
      @resource = Redirect.find(id: params[:id]) || halt(404, "Not Found")
    end

    def allowed_params
      whitelist = [:shortcut, :url]
      params[:redirect].select{|k,v| whitelist.include? k.to_sym }
    end
end
