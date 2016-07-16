module Assets extend self
  #def registered(app)
    #app.set :assets, Sprockets::Environment.new
    #app.set :precompile, %w(screen.css application.js)
    #app.settings.assets.append_path "assets/javascripts"
    #app.settings.assets.append_path "assets/stylesheets"
    #app.settings.assets.append_path "assets/stylesheets"

    #app.configure :development do
      #app.settings.assets.cache = Sprockets::Cache::FileStore.new('./tmp')
      #app.get "/assets/*" do
        #env["PATH_INFO"].sub!("/assets", "")
        #app.settings.assets.call(env)
      #end
    #end
  #end
end
