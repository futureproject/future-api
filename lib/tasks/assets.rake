require 'rake/tasklib'

namespace :assets do
  desc 'Precompile assets'
  task :precompile do
   FileUtils.rm_rf("#{App.root}/public/assets")
   `npm run build`
  end
end

