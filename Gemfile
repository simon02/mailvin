source 'https://rubygems.org'

gem 'sinatra'
gem 'rake'

gem 'datamapper'
gem 'dm-types'
gem 'dm-postgres-adapter'

gem 'multi_json'
gem 'oj'

# used server
gem 'unicorn'

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
