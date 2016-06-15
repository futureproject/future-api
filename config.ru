require "./main"
map("/auth") { run AuthController }
map("/redirects") { run RedirectsController }
map("/api") { run ApiController }
map("/") { run ApplicationController }
