require "bundler/setup"
Bundler.require :bot
Thread.abort_on_exception = true

require "#{Dir.pwd}/main"
require "#{Dir.pwd}/dreamo/bot"

Dreamo::Bot.run
