require "./main"
map("/admin") { run AdminController }
map("/api") { run ApiController }
map("/auth") { run AuthController }
map("/profiles") { run ProfilesController }
map("/registration") { run RegistrationController }
map("/typeform") { run TypeformController }
map("/widgets") { run WidgetsController }
map("/") { run ApplicationController }

