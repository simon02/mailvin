module Mailvin

  # Bunch of application constants that are pulled from environment variables.
  module Constants

    # Web Application Session secret.
    SESSION_SECRET = ENV['SESSION_SECRET'] || 'mailvin1337sessionseccret0!'

  end
end
