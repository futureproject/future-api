require "./main"
map("/admin") { run AdminController }
map("/api") { run ApiController }
map("/auth") { run AuthController }
map("/profiles") { run ProfilesController }
map("/registration") { run RegistrationController }
map("/widgets") { run WidgetsController }
map("/") { run ApplicationController }

Thread.abort_on_exception = true

if ENV["RACK_ENV"] != "test"
  Thread.new do
    begin
      Dreamo::Bot.run
    rescue Exception => e
      STDERR.puts "ERROR: #{e}"
      STDERR.puts e.backtrace
      raise e
    end
  end
end
