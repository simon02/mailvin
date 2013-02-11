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
        # puts params['message-headers']
        headers = JSON.parse(params['message-headers'])
        # find to as a numbnut idiot w two left hands
        to = headers.find { |header|
          key, value = header
          if key == 'To'
            return value
          end
        }.first()
        p 'recipient'
        p params['recipient']
        p 'from'
        p params['from']
        p 'to'
        p to
        puts 'that is all'
        # data = Multimap.new
        # data[:from] = params['recipient']
        # data[:to] = params['from']
        # data[:subject] = "Follow up email sent to #{to}"
        # data[:text] = "Sent auto follow up email to #{to}"
        # data[:html] = "Sent auto follow up email to #{to}"
        # p data
        # RestClient.post "https://api:key-2gwv182xi8z31rlelm54i61qsnxtk9-1@api.mailgun.net/v2/mailvin.mailgun.org/messages", data
        # data = Multimap.new
        # data[:from] = params['from']
        # data[:to] = to
        # data[:subject] = "RE: #{params['subject']}"
        # data[:text] = 'follow up email'
        # data[:html] = 'follow up email'
        # p data
        # RestClient.post "https://api:key-2gwv182xi8z31rlelm54i61qsnxtk9-1@api.mailgun.net/v2/mailvin.mailgun.org/messages", data
        # 'success'
      end

    end
  end
end
