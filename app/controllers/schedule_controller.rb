require 'json'

module Mailvin
  module Web
    class ScheduleController < ApplicationController

      get '/new' do
        erb :schedule
      end

      # Create a new schedule
      post '/' do
        template = params['template']
        puts template['name']
        puts template['description']
        schedule = Mailvin::Web::Schedule.new \
          name: template['name'],
          identifier: template['identifier'],
          description: template['description']
        current_user.projects.first.schedules << schedule
        schedule.save
        current_user.projects.first.save
        redirect '/'
      end

      # Update a schedule
      put '/' do
      end

      get '/mailgun' do
        # get all emails that need to be sent within 10 minutes
        # emails = Mailvin::Web::Email.find :scheduled_at < (Time.now + 10.minutes)
        # check if contextio has checked the account in the last 10 minutes
        # contextio.accounts[emails.sequence.mailbox.contextio_id]
      end

      post '/' do
        puts 'schedule controller post received'
        # puts params['message-headers']
        headers = JSON.parse(params['message-headers'])
        # find to as a numbnut idiot w two left hands
        to = headers.find { |header|
          key, value = header
          key == 'To'
        }.last()
        data = Multimap.new
        data[:from] = params['recipient']
        data[:to] = params['from']
        data[:subject] = "Follow up email sent to #{to}"
        data[:text] = "Sent auto follow up email to #{to}"
        data[:html] = "Sent auto follow up email to #{to}"
        p data
        RestClient.post "https://api:key-2gwv182xi8z31rlelm54i61qsnxtk9-1@api.mailgun.net/v2/mailvin.mailgun.org/messages", data
        data = Multimap.new
        data[:from] = params['from']
        data[:to] = to
        data[:subject] = "RE: #{params['subject']}"
        data[:text] = 'follow up email'
        data[:html] = 'follow up email'
        p data
        RestClient.post "https://api:key-2gwv182xi8z31rlelm54i61qsnxtk9-1@api.mailgun.net/v2/mailvin.mailgun.org/messages", data
        'success'
      end

      # post '/' do
      #   headers = Hash[MultiJson.parse(params['message-headers'])]
      #   from, to = params[:from], headers['To']
      #   account = authenticate!(from)
      #   schedule_name = params[:recipient].split("@").first
      #   schedule = account.schedule schedule_name
      #   schedule.generate \
      #     to: to, from: from, subject: params[:subject],
      # end
    end
  end
end
