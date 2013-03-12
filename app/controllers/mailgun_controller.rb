module Mailvin
  module Web
    class MailgunController < ApplicationController

      # Endpoint accepting incoming emails from mailgun.
      post '/' do
        from, to = params[:sender], params[:To]
        user = authenticate!(from)
        # schedule identifier is part of the email address before @
        schedule_name = params[:recipient].split("@").first
        schedule = user.find_schedule schedule_name
        # generate an email sequence if there is a schedule with that identifier
        if schedule
          schedule.generate \
            to: to, from: from, subject: params[:subject]
        # else map it to a sequence without emails so that the user can later come in and assign it to a schedule
        else
          Sequence.new \
            subject: params[:subject],
            received_at: params[:timestamp]
        end
      end

    end
  end
end
