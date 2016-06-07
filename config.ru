require "./main"
map("/auth") { run AuthController }
map("/redirects") { run RedirectsController }
map("/") { run ApplicationController }
