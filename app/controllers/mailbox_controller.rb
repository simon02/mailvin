module Mailvin
  module Web
    class MailboxController < ApplicationController

      get '/connect' do
        token = contextio.connect_tokens.create "http://#{request.host_with_port}/mailbox/contextio_callback"
        redirect token.browser_redirect_url
      end

      get '/contextio_callback' do
        context_io = ContextIO.new('16f5upaj', 'UsysCe7Aeyhdjvuc')
        connect_token = context_io.connect_tokens[params['contextio_token']]
        account = connect_token.account
        mailbox = Mailvin::Web::User.first.projects.first.mailboxes.find(email: connect_token.email).first
        return 'No mailbox' unless mailbox
        mailbox.authenticated = true
        mailbox.active = true
        mailbox.contextio_id = account.id
        mailbox.save
        flash[:success] = "#{mailbox.email} has been activated. Ready to schedule follow up emails!"
        redirect '/'
      end

    end
  end
end
