require 'active_support/inflector'

module Mailvin

  # Module that contains all of the application code.
  # Provides mechanism to:
  #   * autoload all application files (during development/test)
  #   * preload all application files (during production)
  module Web
    # Application version.
    VERSION = '0.0.1'

    # Root directory of the app
    ROOT = File.expand_path '../app', __FILE__

    # All file patterns that need to be considered for class/module loading
    PATTERNS = ['app/controllers/**/*.rb', 'app/helpers/**/*.rb', 'app/models/gossip.rb', 'app/models/survey.rb', 'app/models/survey_status.rb', 'app/jobs/**/*.rb']

    # Modules that will be loaded in the application
    @@modules = []

    # Internal: Set up autoload for all classes/modules in the PATTERNS
    PATTERNS.each do |pattern|
      Dir.glob(pattern).each do |file|
        # Extract the underscored module name and camelize it using activesupport inflection
        # Example: app/controllers/application_controller.rb => ApplicationController
        module_name = file.sub(/.*\/(.*)\.rb$/,'\1').camelize.to_sym
        # Add this module to the autoloading mechanism
        autoload module_name, file
        # Add this module to the list of loaded modules
        puts "Autoloading Mailvin::Web::#{module_name}" if $debug
        @@modules << module_name
      end
    end

    # Public: Preload all application classes/modules
    # We do this by accessing all constants, which results in all
    # classes and modules being loading due to the autoloading mechanism
    def self.preload
      @@modules.each do |module_name|
        # The module is accessed and thus being loaded
        "Mailvin::Web::#{module_name}".constantize
      end
      puts "Preloaded" if $debug
    end

  end
end
