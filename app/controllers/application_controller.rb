module Mailvin
  module Web

    # Shared controller methods and configurations. Every controller is based
    # on a modular Sinatra instance. This base controller enables and disables
    # the right options of Sinatra. It also provides methods for authentication
    # and authorization to be used in any controller
    # @abstract
    class ApplicationController < Sinatra::Base

      # Partials.
      register Sinatra::Partial
      set :partial_template_engine, :erb

      # Accessing the Flash.
      def flash
        env['x-rack.flash'] || Rack::Flash::FlashHash.new({})
      end

      # Before printing views.
      before do
        puts "[rumor][#{current_email}] :viewed path: #{request.path_info}" unless request.path_info == '/start'
      end

      # Disable all Sinatra settings we don't need
      # Do not handle exceptions, these go to Airbrake
      # enable :raise_errors
      # disable :show_exceptions

      # Do not handle any sessions, this is done in Rack middleware
      disable :session

      # Views can be found in site/
      set :views => 'site/views'
      set :public_folder, ENV['RACK_ENV'] == 'production' ? 'dist' : 'site'

      MENU_ITEMS = Confstruct::Configuration.new do
        admin do
          dashboard do
            name 'Dashboard'
            link '/user/dashboard'
            icon 'icon-signal'
          end
        end
      end

      helpers do
        def menu_items
          MENU_ITEMS
        end
      end

      # Custom error page for unauthorized requests.
      error 401 do
        erb :'401', :layout => :layout_blank
      end

      # Custom error page for forbidded requests.
      error 403 do
        erb :'403', :layout => :layout_blank
      end

      configure :production, :staging do
        error 500 do
          erb :'500', :layout => :layout_blank
        end
      end

      # Authenticates a user based on his session. Redirects to omniauth for
      # authentication when not already signed in. When a parameter domain is
      # added to the url, this method will authenticate the user for that domain,
      # and could thus log out the current user.
      # @note To be used in other controllers that need to be secured.
      # @param [String] path Optional path to redirect to after authentication.
      # @example
      #   get '/hello' do
      #     authenticate!
      #     'secured area'
      #   end
      #
      # @return [String] The domain on which the user is authenticated.
      def authenticate! path = nil
        warn "Deprecated! use allow! instead"
        if path
          allow! :admin, redirect: path
        else
          allow! :admin
        end
      end

      def allow! roles, options = {}
        # Get the optional domain.
        domain = params[:domain]
        # Sign out and re-authenticated if authenticate on other domain is requested.
        if signed_in?
          # Assure predence of enduser role is correct.
          if current_user.active?
            self.roles |= [:enduser]
          else
            self.roles -= [:enduser]
          end
          # Check if the user wants sign in into other domain.
          if domain && domain != current_domain
            signout
            redirect "/auth/google_apps?domain=#{params[:domain]}"
          # Immediately return if signed in.
          elsif role?(*roles)
            current_email
          else
            halt 401
          end
        else
          # Otherwise ask the user to log in and then return here or redirect
          # to another path.
          session[:origin] = options[:redirect] || request.path
          if domain
            redirect "/auth/google_apps?domain=#{params[:domain]}"
          else
            redirect "/auth/google_apps/"
          end
        end
      end

      # @return [Boolean] Check whether the current user is signed in.
      def signed_in?
        !current_email.nil?
      end

      # @return [ContextIO] ruby interface to context.io
      def contextio
        @contextio = @contextio || ContextIO.new('16f5upaj', 'UsysCe7Aeyhdjvuc')
      end

      # @return [String] The Google Apps domain on which the current user is authenticated.
      def current_domain
        session[:email].split("@").last
      end

      # @return [User] The current user.
      def current_user
        user = Mailvin::Web::User.first || do_funky_stuff
      end

      def current_project
        current_user.projects.first
      end

      def do_funky_stuff
        user = Mailvin::Web::User.create \
          login: 'simon',
          password: 'lulspul',
          projects: [
            Mailvin::Web::Project.create(
              name: 'test-project',
              mailboxes: [
                Mailvin::Web::Mailbox.create(
                  email: 'simonbuelens@gmail.com',
                  authenticated: true,
                  active: true,
                  sequences: [
                    Mailvin::Web::Sequence.create(
                      emails: [
                        Mailvin::Web::Email.create(
                          subject: 'Most awesome email evah',
                          to: 'dumbfuck@tralala.com',
                          text: 'Hello - Just checking in to see if you got my email.\n\n\nCheers, Simon',
                          scheduled_at: Time.now + 5.days
                        ),
                        Mailvin::Web::Email.create(
                          subject: 'Most awesome email evah',
                          to: 'dumbfuck@tralala.com',
                          text: 'Hi,\n\nIf you prefer to have a skype chat, just add me: simon.buelens.\n\n\nCheers, Simon',
                          scheduled_at: Time.now + 12.days
                        ),
                        Mailvin::Web::Email.create(
                          subject: 'Most awesome email evah',
                          to: 'dumbfuck@tralala.com',
                          text: 'Hello dumb fuck, fuckin answer back already!\n\n\nCheers, Simon',
                          scheduled_at: Time.now + 25.days
                        )
                      ]
                    )
                  ]
                ),
                Mailvin::Web::Mailbox.create(
                  email: 'simon@gmail.com',
                  authenticated: false,
                  active: false,
                )
              ],
              schedules: [
                Mailvin::Web::Schedule.create(
                  name: 'prospects',
                  description: 'use this template to send to potential new prospects',
                  templates: [
                    Mailvin::Web::Template.create(
                      delay_type: :precise,
                      precise_delay: 259200000, #1000*60*60*24*3
                      text: 'Hello - Just checking in to see if you got my email.\n\n\nCheers, Simon'
                    )
                  ]
                ),
                Mailvin::Web::Schedule.create(
                  name: 'networking',
                  description: 'use this template when trying to grow my network'
                )
              ]
            )
          ]

      end

      def current_project
        # mailbox = Mailvin::Web:Mailbox.new email: 'simonbuelens@gmail.com'
        # mailbox.sequences.new \
        #   emails: { \
        #     text: 'some basic email body text',
        #     subject: 'Most awesome email ever',
        #     from: 'simonbuelens@gmail.com',
        #     to: 'simon@piesync.com',
        #     scheduled_at: Time.now + 1.month
        #   }
        # project = Mailvin::Web::Project.new \
        #   mailboxes: [mailbox]
        # project
      end

      # @return [String] The Google Apps username of the logged in user.
      def current_username
        session[:email].split("@").first
      end

      # @return [String] The email address of the logged in user.
      def current_email
        session[:email]
      end

      # @return [Array] The roles of the logged in user.
      def roles
        session[:roles] || []
      end

      def roles= roles
        session[:roles] = roles
      end

      # @return [Boolean] Check if the logged in user has some roles.
      def role? *roles
        roles.any? { |role| self.roles.include? role }
      end

      # @return The role with the most permissions.
      def highest_role
        ([:enduser, :admin, :staff] & self.roles).last
      end

      # We use SSO for authentication. When a user logs in, it
      # can be the first time he logs in. If this is the case,
      # we create a `user` (and `domain`) record for that user in the database.
      #
      # @param [String] email The email address of the user.
      def signup_or_signin email, roles = []
        # First sign in the user.
        signin email, roles
        puts "[rumor][#{email}] :signed_in"
        # Immediately query for the user.
        user = User.find email
        # It does not exists, sign up.
        if user.nil?
          # Create the user (and possibly the domain).
          domain = Domain.find(current_domain)

          # Create domain if necessary.
          if domain.nil?
            domain = Domain.create(name: current_domain)
            puts "[rumor][#{email}] :registered #{domain.name}"

            # Load all users for the domain.
            ProvisioningHelper.load_users! domain
          end

          # Make sure the current user is present.
          domain.users.create email: email unless \
            domain.users.to_a.find { |user| user.email == email}
        end
      end

      # Log in a certain user of a domain using his email address.
      #
      # @param [String] email The email address of the user.
      # @param [Array] roles The roles of this user (:enduser, :admin, :staff).
      def signin email, roles = []
        # Save it in the session.
        session[:email] = email
        self.roles = roles
        # gossip
        gossip.say(:user, :signin) {}
      end

      # Signs out the current user.
      def signout
        session[:email] = nil
        self.roles = nil
        redirect 'http://www.piesync.com'
      end
    end
  end
end
