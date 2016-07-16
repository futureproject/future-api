class App < Sinatra::Base
  register Sinatra::Sprockets::Helpers
  set :sprockets, Sprockets::Environment.new(root)
  set :assets_prefix, '/assets'
  set :assets_to_compile, %w(application.js screen.css)
  set :digest_assets, production?

  configure do
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'javascripts')
    sprockets.append_path File.join(root, 'assets', 'images')

    configure_sprockets_helpers do |helpers|
      #helpers.asset_host = 'some-bucket.s3.amazon.com'
    end
  end

  configure :development do
    sprockets.cache = Sprockets::Cache::FileStore.new('./tmp')
    get "/assets/*" do
      env["PATH_INFO"].sub!("/assets", "")
      settings.sprockets.call(env)
    end
  end

end
