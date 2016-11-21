require 'rake/tasklib'

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    `webpack -p --config config/webpack.config.js`
    #environment = App.settings.sprockets
    #manifest = Sprockets::Manifest.new(environment.index, "#{Dir.pwd}/public#{App.settings.assets_prefix}/manifest.json")
    #manifest.compile(App.settings.assets_to_compile)
  end

  desc "Clean assets"
  task :clean do
    FileUtils.rm_rf("#{App.root}/public/assets")
  end
end

