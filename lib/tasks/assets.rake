require 'rake/tasklib'
require 'rake/sprocketstask'

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
    environment = App.settings.sprockets
    manifest = Sprockets::Manifest.new(environment.index, "#{Dir.pwd}/public#{App.settings.assets_prefix}/manifest.json")
    manifest.compile(App.settings.assets_to_compile)
  end

  desc "Clean assets"
  task :clean do
    FileUtils.rm_rf(App.assets_path)
  end
end

