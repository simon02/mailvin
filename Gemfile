source 'https://rubygems.org'

gem 'sinatra'
gem 'rake'

gem 'datamapper'

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

# views
gem 'mustache'

group :production do
  gem 'dm-postgres-adapter'
end

group :development do
  # sqlite database
  gem 'sqlite3'
  gem 'dm-sqlite-adapter'

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
