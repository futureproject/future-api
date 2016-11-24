threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

workers Integer(ENV['WEB_CONCURRENCY'] || 2)

before_fork do
  if defined?(App::DB)
    App::DB.disconnect
  end
end

