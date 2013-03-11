module Mailvin
  module Web

    class Email
      include DataMapper::Resource
      storage_names[:default] = 'emails'

      belongs_to :sequence
      belongs_to :template, required: false

      property :id, Serial
      property :text, Text
      property :subject, String
      property :from, String
      property :to, String
      property :scheduled_at, DateTime
      property :sent, Boolean, default: false
      # indicates if the email still needs to be sent
      property :active, Boolean, default: true

      def self.scheduled options = {}
        all({active: true}.merge! options)
      end

      def self.past options = {}
        all({active: false}.merge! options)
      end
    end
  end
end
