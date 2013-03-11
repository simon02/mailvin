require 'irb'

task :environment do
  require './config/boot'
  require './config/environment'
  Mailvin::Web.preload
end

task :console => :environment do
  ARGV.clear
  IRB.start
end
