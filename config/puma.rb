workers Integer(ENV['WEB_CONCURRENCY'] || 16)
threads_count = Integer(ENV['MAX_THREADS'] || 16)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

#on_worker_boot do
  #ActiveRecord::Base.establish_connection
#end
