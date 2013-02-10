# Boot if necessary to make this config file still stand alone
load 'config/boot.rb' unless $environment

# Require the environment the environment
require 'config/environment'

# Require the web stack
require 'config/web_stack'

# Run the web stack
run Mailvin::Web::RACK
