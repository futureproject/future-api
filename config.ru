require "./main"
map("/auth") { run AuthController }
map("/redirects") { run RedirectsController }
map("/api") { run ApiController }
map("/") { run ApplicationController }

Thread.abort_on_exception = true
  Thread.new do
    begin
      Dreamo::Bot.run
    rescue Exception => e
      STDERR.puts "ERROR: #{e}"
      STDERR.puts e.backtrace
    raise e
  end
end
