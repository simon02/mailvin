module Mailvin
  module Web
    class ScheduleController < Sinatra::Base

      get '/' do
        puts 'schedule controller get received'
        []
      end

      post '/' do
        puts 'schedule controller post received'
        []
      end

    end
  end
end
