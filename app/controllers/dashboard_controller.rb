require 'json'

module Mailvin
  module Web
    class DashboardController < ApplicationController

      get '/' do
        project = current_user.projects.first
        @scheduled_emails = project.emails.scheduled(limit: 10)
        @nr_scheduled_emails = project.emails.scheduled.count
        @past_emails = project.emails.past(limit: 10)
        @nr_past_emails = project.emails.past.count
        @project = project
        erb :dashboard
      end

      get '/parameter_check' do
        p params
      end

    end
  end
end
