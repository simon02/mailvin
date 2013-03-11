module Mailvin
  module Web
    class AuthenticationController < ApplicationController

      get '/access_token' do
        @callback_url = '/auth/callback'
        @consumer = OAuth::Consumer.new("key","secret", :site => "https://agree2")
        @request_token = @consumer.get_request_token(:oauth_callback => @callback_url)
        session[:request_token] = @request_token
        redirect_to @request_token.authorize_url(:oauth_callback => @callback_url)
      end

      get '/callback' do
      end

    end
  end
end
