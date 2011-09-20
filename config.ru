# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'resque/server'
require 'resque_scheduler'

run Rack::URLMap.new \
  "/"       => Watchdog::Application,
  "/resque" => Resque::Server.new