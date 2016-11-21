require "./main"
map("/admin") { run AdminController }
map("/api") { run ApiController }
map("/auth") { run AuthController }
map("/profiles") { run ProfilesController }
map("/registration") { run RegistrationController }
map("/widgets") { run WidgetsController }
map("/") { run ApplicationController }

#compile assets in development mode
if ENV["RACK_ENV"] == "development"
  Thread.new do
    `npm run build-dev`
  end
end

