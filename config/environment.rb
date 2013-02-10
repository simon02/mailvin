# Load environment variables.
require 'config/constants'

# Load the application module
# Does no heavy lifting, only initializes autoload directives
require 'app'

# Log which version of the app is booting.
puts "Loading Application version #{Mailvin::Web::VERSION}" if $debug

# Public: A more user friendly environment
module Mailvin

  # Manages all configuration needed for the application to run.
  #
  # * Multi stage setup.
  # * Initializers per environment per library.
  # * Variables loaded from environment or defaults.
  #
  class Environment
    # Pull Constants from environment variables or defaults.
    include Constants

    # Public: Check if we are in the development environment
    # Returns true if we are, false otherwise
    def self.development?
      $environment == :development
    end

    # Public: Check if we are in the production environment
    # Returns true if we are, false otherwise
    def self.production?
      $environment == :production
    end

    # Public: Check if we are in the staging environment
    # Returns true if we are, false otherwise
    def self.staging?
      $environment == :staging
    end

    # Public: Check if we are in the test environment
    # Returns true if we are, false otherwise
    def self.test?
      $environment == :test
    end

    # Public: Get the identifier for this environment
    # Returns identifier as symbol
    def self.name
      $environment
    end

    # Public: Loads all configuration for gems and/or lib modules
    # These configuration is under /config/initializers.
    # The shared configurations are in the root directory.
    # Environment specific configurations have a directory of their own.
    def self.load_configurations
      path     = File.expand_path('../', __FILE__)
      shared   = "#{path}/initializers/*.rb"
      specific = "#{path}/initializers/#{$environment}/*.rb"
      # Load all configurations
      (Dir.glob(shared) + Dir.glob(specific)).each do |file|
        puts "Loaded configuration #{file.split('/').last}" if $debug
        load file
      end
    end
  end
end

# Alias
$env = Mailvin::Environment

# Load all configurations at once
Mailvin::Environment.load_configurations
