module Mailvin

  # Bunch of application constants that are pulled from environment variables.
  module Constants

    # Web Application Session secret.
    SESSION_SECRET = ENV['SESSION_SECRET'] || 'mailvin1337sessionseccret0!'

    # contextio settings
    CONTEXTIO_KEY = ENV['CONTEXTIO_KEY']
    CONTEXTIO_SECRET = ENV['CONTEXTIO_SECRET']

  end
end
