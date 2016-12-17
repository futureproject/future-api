require "./main"
map("/admin") { run AdminController }
map("/api/v1") { run API::V1::Controller }
map("/api") { run ApiController }
map("/auth") { run AuthController }
map("/profiles") { run ProfilesController }
map("/registration") { run RegistrationController }
map("/widgets") { run WidgetsController }
map("/") { run ApplicationController }
