class Frank < Sinatra::Base

  def get_redirect
    @redirect = Redirect.find(id: params[:id]) || halt(404, "Not Found")
  end

  def allowed_params
    whitelist = [:shortcut, :url]
    params[:redirect].select{|k,v| whitelist.include? k.to_sym }
  end

  get '/' do
    @redirects = Redirect.reverse_order(:id)
    haml :index
  end

  get '/redirects/new' do
    @redirect = Redirect.new
    haml :form
  end

  get '/redirects/:id/edit' do
    get_redirect
    haml :form
  end

  post '/redirects' do
    @redirect = Redirect.new(allowed_params)
    begin
      @redirect.save
      redirect '/'
    rescue Sequel::ValidationFailed
      haml :form
    end
  end

  post '/redirects/:id' do
    get_redirect
    begin
      @redirect.update allowed_params
      redirect '/'
    rescue Sequel::ValidationFailed
      haml :form
    end
  end

  get '/redirects/:id/destroy' do
    @redirect = Redirect.find(id: params[:id])
    @redirect.delete
    redirect '/'
  end

  get '/:shortcut' do
    url = Redirect.find(shortcut: params[:shortcut]).url rescue settings.default_redirect
    redirect url
  end

end
