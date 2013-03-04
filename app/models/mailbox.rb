module Mailvin
  module Web

    class Mailbox
      include DataMapper::Resource
      storage_names[:default] = 'mailboxes'

      belongs_to :project
      has n, :sequences

      property :id, Serial
      property :email, String
      property :contextio_id, String
      property :authenticated, Boolean, default: false
      property :active, Boolean

    end
  end
end
