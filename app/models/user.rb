module Mailvin
  module Web

    class User
      include DataMapper::Resource
      storage_names[:default] = 'users'

      has n, :projects
      has n, :mailboxes

      property :id, Serial
      property :login, String
      property :password, String

      def find_schedule identifier
        projects.first.schedules.first identifier: identifier
      end

    end
  end
end
