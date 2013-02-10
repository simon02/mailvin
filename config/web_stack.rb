# We need the environment to offer and environment specific stack
require 'config/environment'

# Set up our entire web stack with Rack middleware
Mailvin::Web::RACK = Rack::Builder.app do
  # Gzips all responses for faster transfers over the wire
  use Rack::Deflater

  # Log all exceptions to Airbrake in production
  # use Rack::Exceptional, $env::EXCEPTIONAL_KEY if $env.production? || $env.staging?

  # Shortcuts static files (assets)
  # So these requests don't have to go through the entire stack
  use Rack::StaticCache, :urls => ['/assets'], :root => 'public'

  # Store the session information encrypted in a cookie
  # Makes our server entirely stateless
  use Rack::Session::Cookie,
    key: 'rack.session',
    path: '/',
    expire_after: 86400, # 24 hours
    secret: $env::SESSION_SECRET

  # Flashing users about important events.
  use Rack::Flash, accessorize: [:error], sweep: true

  # Allow forms to make put and delete requests.
  use Rack::MethodOverride

  # Routing for public controllers
  public_routes = {
    '/schedule'       => Mailvin::Web::ScheduleController
  }

  # Routing for secured controllers
  secured_routes = {
  }

  # Secure inner app
  secure = Rack::Builder.app {
    # Configure the security
    use Rack::Auth::Basic, 'Restricted' do |username, password|
      [username, password] == [$env::APP_USERNAME, $env::APP_PASSWORD]
    end
    # Attach the secured routes
    run Rack::URLMap.new(secured_routes)
  }

  # Mix the routes into the final app
  run Rack::URLMap.new public_routes.merge('/admin' => secure)
end

puts 'Web stack initialized' if $debug
