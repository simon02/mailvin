# config path
$: << File.expand_path('../../',__FILE__)
$: << File.expand_path('../../lib/',__FILE__)

# set the environment to the external rack env
$environment ||= ENV['RACK_ENV'].to_sym

# Debug bootstrap process if necessary
$debug = ENV['DEBUG'] == 'true'

# require bundler
require 'bundler'

# require all gems that are default and in the group of the current environment
Bundler.require(:default, $environment)

puts 'Gems loaded' if $debug

require 'mustache/sinatra'          # mustache for sinatra

require 'active_support/core_ext/hash'

puts 'Additional dependencies loaded' if $debug
