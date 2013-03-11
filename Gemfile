source 'https://rubygems.org'

# web app framework
gem 'sinatra', :require => 'sinatra/base'
gem 'sinatra-partial', :require => 'sinatra/partial'

# easy configurations
gem 'confstruct'

gem 'rake'

gem 'datamapper'
gem 'dm-types'
gem 'dm-postgres-adapter'

gem 'multi_json'
gem 'oj'

# used server
gem 'unicorn'

# making use of typhoeus
gem 'typhoeus'

# rack based
gem 'rack', '1.4'
gem 'rack-contrib', :require => 'rack/contrib'
gem 'rack-rewrite' # rewrite url's

# caching
#gem 'rack-cache'

# flashing
gem 'rack-flash3', :require => 'rack-flash'

# active support for cool stuff
gem 'activesupport', :require => 'active_support'

# sending mails via mailgun
gem 'rest-client'
gem 'multimap'

# contextio
gem 'contextio', :git => 'https://github.com/contextio/contextio-ruby', :branch => 'avoid_passing_around_nil_associations'

# views
gem 'mustache'

group :development do
  # used server
  gem 'thin'

  # process configuration
  gem 'foreman', '0.25.0'

  # source reloading
  gem 'shotgun'

  # guard
  gem 'guard'
  gem 'guard-coffeescript' # compiling coffeescrips
  gem 'guard-sass'         # compiling sass
end
