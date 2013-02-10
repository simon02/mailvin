require 'json'

module Mailvin
  module Web
    class ScheduleController < Sinatra::Base

      get '/' do
        puts 'schedule controller get received'
        []
      end

      post '/' do
        puts 'schedule controller post received'
        headers = JSON.parse(params['message-headers'])
        p headers
        to = headers['to']
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

    end
  end
end
