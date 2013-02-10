# https://github.com/blog/517-unicorn

worker_processes 3 # amount of unicorn workers to spin up
timeout 25         # restarts workers that hang for 30 seconds

require './config/boot.rb'
require 'config/environment'

# Preload the app for extra efficiency
Mailvin::Web.preload
